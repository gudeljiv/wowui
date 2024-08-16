------------------------
---NovaInstanceTracker--
------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");
local lootReminderFrame, lootReminderListFrame;
local lastLootNpcID, lastBossNpcID, lastBossTime;
local tinsert = tinsert;

local msgTimer, fadeTimer;
local function hideMiddleMsg()
	UIFrameFadeOut(lootReminderFrame, lootReminderFrame:GetAlpha(), lootReminderFrame:GetAlpha(), 0);
	if (fadeTimer) then
		fadeTimer:Cancel();
	end
	fadeTimer = C_Timer.NewTimer(1, function()
		lootReminderFrame.StopBounce();
	end)
	if (msgTimer) then
		msgTimer:Cancel();
	end
end

local function addMsg(msg, time)
	if (not NIT.db.global.lootReminderReal) then
		return;
	end
	lootReminderFrame.StopBounce();
	if (msgTimer) then
		msgTimer:Cancel();
	end
	if (fadeTimer) then
		fadeTimer:Cancel();
	end
	lootReminderFrame.fs:SetText("|cFF00FF00[NIT]|r |cFFFFFF00" .. msg);
	UIFrameFadeIn(lootReminderFrame, 0, 0, 1)
	msgTimer = C_Timer.NewTimer(time, function()
		hideMiddleMsg();
	end)
	lootReminderFrame.StartBounce();
end

function NIT:updateLootReminderFrame(runTest)
	lootReminderFrame:SetPoint("CENTER", UIParent, NIT.db.global.lootReminderX, NIT.db.global.lootReminderY);
	lootReminderFrame.fs:SetFont(NIT.regionFont, NIT.db.global.lootReminderSize, "OUTLINE");
	lootReminderFrame.defaultX = NIT.db.global.lootReminderX;
    lootReminderFrame.defaultY = NIT.db.global.lootReminderY;
	if (runTest) then
		addMsg("Loot reminder test.", 10);
	end
end

function NIT:loadLootReminderFrame()
	local frame = CreateFrame("Frame", "NITLootReminderFrame", UIParent);
	frame:SetSize(1, 1);
	frame:SetPoint("CENTER", UIParent, -10, 100);
	frame.fs = frame:CreateFontString("NITLootReminderFrameFS", "ARTWORK");
	frame.fs:SetPoint("CENTER", 0, 0);
	--NIT:ApplyBounce(frame, 50, 0.5, nil, true);
	NIT:ApplyBounce(frame, 40, 0.4, nil, true);
	
	---Some failed testing attempts below.
	
	--[[frame.animationGroup = frame:CreateAnimationGroup();
	frame.animationGroup:SetLooping("BOUNCE");
	local bounce = frame.animationGroup:CreateAnimation("Translation");
	bounce:SetChildKey("NITLootReminderFrame");
	bounce:SetOffset(0, 40);
	bounce:SetDuration(0.05);
	bounce:SetScript("OnUpdate", function()
		bounce:SetDuration(0.05 + (bounce:GetSmoothProgress() * 0.27));
	end)]]
	
	
    --[[local fadeIn = lootReminderFrame.animationGroup:CreateAnimation("Alpha")
    fadeIn:SetChildKey("enchantBorder")
    fadeIn:SetDuration(0.4)
    fadeIn:SetFromAlpha(0)
    fadeIn:SetToAlpha(1)]]
    
    
    
	--[[frame.animation = {};
	frame.defaultX = -10;
	frame.defaultY = 100;
	frame.animation.startAnimation = function()
		frame.lastUpdate = 0;
		frame.yOffset = 1;
		frame.animationDirection = 1;
		frame.animationDistancePerUpdate = 2.45;
		frame.animationUpdateFrequency = 0.01;
		frame.animationHeight = 50;
		frame:SetScript("OnUpdate", function(self)
			if (GetTime() - frame.lastUpdate > frame.animationUpdateFrequency) then
				--if (frame.yOffset >= frame.animationHeight) then
				--	frame.animationDirection = 0;
				--elseif (frame.yOffset <= 0) then
				--	frame.animationDirection = 1;
				--	prin(2)
				end
				local _, _, _, x, y = frame:GetPoint();
				if (y >= frame.defaultY + frame.animationHeight) then
					frame.animationDirection = 0;
				end
				if (y <= frame.defaultY) then
					frame.animationDirection = 1;
					frame.animationDistancePerUpdate = 2.45;
				end
				local distance = GetFramerate() / 160;frame.animationDistancePerUpdate
				if (frame.animationDirection == 1) then
					frame.animationDistancePerUpdate = frame.animationDistancePerUpdate - 0.05;
					frame.yOffset = frame.yOffset + frame.animationDistancePerUpdate;
					frame:SetPoint("CENTER", UIParent, frame.defaultX, frame.defaultY + frame.yOffset);
					--frame:SetPoint("CENTER", UIParent, frame.defaultX, frame.defaultX + (frame.xOffset - (frame.xOffset * 0.3)));
				else
					frame.animationDistancePerUpdate = frame.animationDistancePerUpdate + 0.05;
					frame.yOffset = frame.yOffset - frame.animationDistancePerUpdate;
					frame:SetPoint("CENTER", UIParent, frame.defaultX, frame.defaultY + frame.yOffset);
				end
				frame.lastUpdate = GetTime();
				--print(frame.animationDirection, frame.animationDistancePerUpdate, frame.yOffset)
			end
		end)
	end
	frame.animation.stopAnimation = function()
		frame:SetScript("OnUpdate", nil);
		frame:SetPoint("CENTER", UIParent, frame.defaultX, frame.defaultY);
	end;]]
    
	lootReminderFrame = frame;
end

--Big thanks to Ghost for this animation effect.
--https://github.com/Ghostopheles/Verity/blob/719bb6f3723451e4a2e86387e93a6576d5282f61/Rustbolt/Core/Animations.lua#L22-L67
---@param object any
---@param bounceHeight? number
---@param duration? number
---@param smoothing? string
---@param doNotStart? boolean
function NIT:ApplyBounce(object, bounceHeight, duration, smoothing, doNotStart)
    local defaults = {
        BounceHeight = 50,
        Duration = 0.5,
        Smoothing = "OUT",
    };
    local point, relativeTo, relativePoint, offsetX, offsetY = object:GetPointByName("CENTER");
    local animGroup = object.AnimGroup or object:CreateAnimationGroup();
    animGroup:SetLooping("BOUNCE");
    animGroup.Anim = animGroup.Anim or animGroup:CreateAnimation("Animation");

    local anim = animGroup.Anim;
    anim:SetDuration(duration or defaults.Duration);
    anim:SetSmoothing(smoothing or defaults.Smoothing);

    local function Tick(_)
        local progress = math.sin(anim:GetSmoothProgress());
        local targetOffset = (bounceHeight or defaults.BounceHeight) * progress;
        object:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY + targetOffset);
    end

    anim:SetScript("OnUpdate", Tick);

    local function StartBounce()
        animGroup:Play();
    end

    local function StopBounce(_, noReset)
        animGroup:Stop();
        if noReset then
            return;
        end
        object:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY);
    end

    object.StartBounce = StartBounce;
    object.StopBounce = StopBounce;

    if doNotStart then
        return;
    end

    StartBounce();
end
NIT:loadLootReminderFrame();

function NIT:argentDawnTrinketReminder()
	if (not NIT.db.global.argentDawnTrinketReminder) then
		return;
	end
	if (NIT.expansionNum > 4) then
		return;
	end
	local _, _, _, _, _, _, _, instanceID = GetInstanceInfo();
	if (instanceID == 289 or instanceID == 329) then
		local factionName, _, standing = GetFactionInfoByID(529);
		if (standing and standing < 8 and standing ~= 0) then
			local trinkets = {
				[1] = {
					itemID = 13209,
					name = "|cFF0070DD[Seal of the Dawn]|r",
				},
				[2] = {
					itemID = 19812,
					name = "|cFF0070DD[Rune of the Dawn]|c",
				},
				[3] = {
					itemID = 12846,
					name = "|cFFFFFFFF[Argent Dawn Commission]|r",
				},
			};
			local isEquipped;
			for k, v in ipairs(trinkets) do
				if (C_Item.IsEquippedItem(v.itemID)) then
					isEquipped = true;
				end
			end
			if (not isEquipped) then
				for k, v in ipairs(trinkets) do
					local trinket = GetItemCount(v.itemID);
					if (trinket and trinket > 0) then
						local _, itemLink = C_Item.GetItemInfo(v.itemID);
						local itemString;
						if (itemLink) then
							itemString = itemLink;
						else
							itemString = v.name;
						end
						NIT:print("|cFF00FF00" .. L["Reminder"] .. ":|r " .. string.format(L["missingArgentDawnTrinket"], factionName, itemString));
						addMsg("|cFF00FF00" .. L["Reminder"] .. ":|r " .. string.format(L["missingArgentDawnTrinket"], factionName, itemString), 4);
						return;
					end
				end
			end
		end
	end
end

if (not NIT.isSOD) then
	return;
end

local dungeons = {
	[289] = "Scholomance",
	[329] = "Stratholme",
	[429] = "Dire Maul",
	[230] = "Blackrock Depths",
	[229] = "Blackrock Spire",
	[2784] = "Demonfall Canyon",
};

--Some bosses are missing encounter_end event in classic we need a db of all the bosses.
--Tarnished Undermine Real bosses.
--Order field is the most comon order these would be killed in for display purposes.
local turBosses = {
	--Stratholme (1-9 live side, 10+ undead side).
	[-100] = {header = true, title = "Live Side", instanceID = 329, order = 0},
	[11058] = {name = "Ezra Grimm", instanceID = 329, order = 1},
	[10516] = {name = "The Unforgiven", instanceID = 329, order = 2},
	[11143] = {name = "Postmaster Malown", instanceID = 329, order = 3},
	[10808] = {name = "Timmy the Cruel", instanceID = 329, order = 4},
	[11032] = {name = "Malor the Zealous", instanceID = 329, order = 5},
	[10997] = {name = "Cannon Master Willey", instanceID = 329, order = 6},
	[10811] = {name = "Archivist Galford", instanceID = 329, order = 7},
	[10813] = {name = "Balnazzar", instanceID = 329, order = 8},
	[-101] = {header = true, title = "Undead Side", instanceID = 329, order = 10},
	[10437] = {name = "Nerub'enkan", instanceID = 329, order = 14},
	[10436] = {name = "Baroness Anastari", instanceID = 329, order = 12},
	[10438] = {name = "Maleki the Pallid", instanceID = 329, order = 15},
	[10435] = {name = "Magistrate Barthilas", instanceID = 329, order = 11},
	--[11121] = {name = "Black Guard Swordsmith", instanceID = 329, order = 13}, --Doesn't drop.
	[10439] = {name = "Ramstein the Gorger", instanceID = 329, order = 16},
	[10440] = {name = "Baron Rivendare", instanceID = 329, order = 17},
	--[11120] = {name = "Crimson Hammersmith", instanceID = 329, order = 99}, --Needs testing (spawnable mob unlikely to drop).
	--[10812] = {name = "Grand Crusader Dathrohan", instanceID = 329, order = 99}, --Becomes Balnazzar halfway through the fight.
	--[10558] = {name = "Hearthsinger Forresten", instanceID = 329, order = 99}, --Needs testing.
	--[10393] = {name = "Skul", instanceID = 329, order = 99}, --Needs testing (rare mob so unlikely to drop).
	--[10809] = {name = "Stonespine", instanceID = 329, order = 99}, --Needs testing (rare mob so unlikely to drop).
	
	--Scholomance.
	[10506] = {name = "Kirtonos the Herald", instanceID = 289, order = 1},
	[10503] = {name = "Jandice Barov", instanceID = 289, order = 2},
	[11622] = {name = "Rattlegore", instanceID = 289, order = 3},
	[10433] = {name = "Marduk Blackpool", instanceID = 289, order = 4},
	[10432] = {name = "Vectus", instanceID = 289, order = 5},
	[10508] = {name = "Ras Frostwhisper", instanceID = 289, order = 6},
	[10505] = {name = "Instructor Malicia", instanceID = 289, order = 7},
	[11261] = {name = "Doctor Theolen Krastinov", instanceID = 289, order = 8},
	[10901] = {name = "Lorekeeper Polkelt", instanceID = 289, order = 9},
	[10507] = {name = "The Ravenian", instanceID = 289, order = 10},
	[10504] = {name = "Lord Alexei Barov", instanceID = 289, order = 11},
	[10502] = {name = "Lady Illucia Barov", instanceID = 289, order = 12},
	[1853] = {name = "Darkmaster Gandling", instanceID = 289, order = 13},
	
	--Blackrock Depths. (Which BRD bosses can drop them? Not all can I think, this list is which on wowhead has seen a drop but probably not complete.
	[9016] = {name = "Bael'Gar", instanceID = 230, order = 1},
	[9017] = {name = "Lord Incendius", instanceID = 230, order = 2},
	[9056] = {name = "Fineous Darkvire", instanceID = 230, order = 3},
	[9033] = {name = "General Angerforge", instanceID = 230, order = 4},
	[8983] = {name = "Golem Lord Argelmach", instanceID = 230, order = 5},
	[9537] = {name = "Hurley Blackbreath", instanceID = 230, order = 6},
	[9502] = {name = "Phalanx", instanceID = 230, order = 7},
	[9156] = {name = "Ambassador Flamelash", instanceID = 230, order = 8},
	[9938] = {name = "Magmus", instanceID = 230, order = 9},
	[9019] = {name = "Emperor Dagran Thaurissan", instanceID = 230, order = 10},
	
	--Dire Maul (1-9 east, 10-19 west, 20+ north).
	[-102] = {header = true, title = "East", instanceID = 429, order = 0},
	[14354] = {name = "Pusillin", instanceID = 429, order = 1},
	[11490] = {name = "Zevrim Thornhoof", instanceID = 429, order = 2},
	[13280] = {name = "Hydrospawn", instanceID = 429, order = 3},
	[14327] = {name = "Lethtendris", instanceID = 429, order = 4},
	[11492] = {name = "Alzzin the Wildshaper", instanceID = 429, order = 5},
	[-103] = {header = true, title = "West", instanceID = 429, order = 10},
	[11489] = {name = "Tendris Warpwood", instanceID = 429, order = 11},
	[11488] = {name = "Illyanna Ravenoak", instanceID = 429, order = 12},
	[11487] = {name = "Magister Kalendris", instanceID = 429, order = 13},
	--[11467] = {name = "Tsu'zee", instanceID = 429, order = 14}, --Needs testing (rare mob so unlikely to drop).
	[11496] = {name = "Immol'thar", instanceID = 429, order = 15},
	[11486] = {name = "Prince Tortheldrin", instanceID = 429, order = 16},
	[-104] = {header = true, title = "North", instanceID = 429, order = 20},
	--[14326] = {name = "Guard Mol'dar", instanceID = 429, order = 21}, --Some north bosses don't drop, probably for tribute run reasons.
	--[14322] = {name = "Stomper Kreeg", instanceID = 429, order = 22}, --Some north bosses don't drop, probably for tribute run reasons.
	--[14321] = {name = "Guard Fengus", instanceID = 429, order = 23}, --Some north bosses don't drop, probably for tribute run reasons.
	--[14323] = {name = "Guard Slip'kik", instanceID = 429, order = 24}, --Some north bosses don't drop, probably for tribute run reasons.
	--[14325] = {name = "Captain Kromcrush", instanceID = 429, order = 25}, --Some north bosses don't drop, probably for tribute run reasons.
	--[14324] = {name = "Cho'Rush the Observer", instanceID = 429, order = 26}, --The add during the last boss fight, no drop?
	[11501] = {name = "King Gordok", instanceID = 429, order = 27},
	
	--Demonfall Canyon.
	[226923] = {name = "Grimroot", instanceID = 2784, order = 1},
	[228022] = {name = "The Destructor's Wraith", instanceID = 2784, order = 2},
	[226922] = {name = "Zilbagob", instanceID = 2784, order = 3},
	[227140] = {name = "Pyranis", instanceID = 2784, order = 4},
	[227019] = {name = "Diathorus the Seeker", instanceID = 2784, order = 5},
	[227028] = {name = "Hellscream's Phantom", instanceID = 2784, order = 6},
	
	--Blackrock Spire (1-9 lower, 10+ upper).
	[-105] = {header = true, title = "Upper", instanceID = 229, order = 0},
	[9816] = {name = "Pyroguard Emberseer", instanceID = 229, order = 1},
	--[10264] = {name = "Solakar Flamewreath", instanceID = 229, order = 2}, -- No drop.
	--[10899] = {name = "Goraluk Anvilcrack", instanceID = 229, order = 3}, --No drop.
	--[10339] = {name = "Gyth <Rend Blackhand's Mount>", instanceID = 229, order = 4}, --No drop.
	[10429] = {name = "Warchief Rend Blackhand", instanceID = 229, order = 5},
	[10430] = {name = "The Beast", instanceID = 229, order = 6},
	[10363] = {name = "General Drakkisath", instanceID = 229, order = 7},
	--[10509] = {name = "Jed Runewatcher", instanceID = 229, order = 99}, --No drop.
	[-106] = {header = true, title = "Lower", instanceID = 229, order = 10},
	[9196] = {name = "Highlord Omokk", instanceID = 229, order = 11},
	[9236] = {name = "Shadow Hunter Vosh'gajin", instanceID = 229, order = 12},
	[9237] = {name = "War Master Voone", instanceID = 229, order = 13},
	[10596] = {name = "Mother Smolderweb", instanceID = 229, order = 14},
	[10584] = {name = "Urok Doomhowl", instanceID = 229, order = 15},
	--[9736] = {name = "Quartermaster Zigris", instanceID = 229, order = 16}, --Needs testing.
	[10220] = {name = "Halycon", instanceID = 229, order = 17},
	[10268] = {name = "Gizrul the Slavener", instanceID = 229, order = 18},
	[9568] = {name = "Overlord Wyrmthalak", instanceID = 229, order = 19},
};

local function getBossCount(instanceID)
	local count, headerCount = 0, 0;
	for k, v in pairs(turBosses) do
		if (v.instanceID == instanceID) then
			if (v.header) then
				headerCount = headerCount + 1;
			else
				count = count + 1;
			end
		end
	end
	return count, headerCount;
end

local function getLootedStatus(npcID, itemID)
	local data = NIT.data.myChars[UnitName("player")].bossKills[npcID];
	if (data and data.looted and data.looted[itemID] and data.resetTime and data.resetTime > GetServerTime()) then
		return true;
	elseif (data and data.resetTime and data.resetTime > GetServerTime()) then
		--Killed but not looted.
		return false, true;
	end
end

function NIT:getLootReminderMinimapString()
	if (NIT.currentInstanceID and dungeons[NIT.currentInstanceID] and UnitLevel("player") > 44) then
		local text = "";
		local sorted = {};
		local count = 0;
		local lootedCount = 0;
		for k, v in pairs(turBosses) do
			if (v.instanceID == NIT.currentInstanceID) then
				local t = {
					npcID = k,
					name = v.name,
					order = v.order,
					instanceID = v.instanceID,
					header = v.header,
					title = v.title,
				};
				tinsert(sorted, t);
			end
		end
		table.sort(sorted, function(a, b) return a.order < b.order end);
		for k, v in pairs(sorted) do
			count = count + 1;
			if (v.header) then
				local headerString = "|cFF9CD6DE[" .. v.title  .. "]|r";
				if (count == 1) then
					text = text .. headerString;
				else
					text = text .. "\n" .. headerString;
				end
			else
				local looted, isKilledButNotLooted = getLootedStatus(v.npcID, 226404);
				local lootedString;
				if (isKilledButNotLooted) then
					lootedString = "|cFFFF6900(" .. L["Killed But Not Looted"] .. ")|r";
				elseif (looted) then
					lootedString = "|cFF00FF00(" .. L["Looted"] .. ")|r";
					lootedCount = lootedCount + 1;
				else
					lootedString = "|cFFFF0000(" .. L["Not Looted"] .. ")|r";
				end
				if (count == 1) then
					text = text .. "|cFFFFAE42".. v.name .. "|r  " .. lootedString;
				else
					text = text .. "\n|cFFFFAE42" .. v.name .. "|r  " .. lootedString;
				end
			end
		end
		local bossCount, headerCount = getBossCount(NIT.currentInstanceID);
		local lootedString
		if (lootedCount >= bossCount) then
			lootedString = "|cFF00FF00" .. lootedCount .. "/" .. bossCount .. "|r";
		else
			lootedString = "|cFF9CD6DE " .. lootedCount .. "/" .. bossCount .. "|r";
		end
		local header = "|cFFFFFF00" .. L["Tarnished Undermine Real"] .. "|r - " .. lootedString .. "\n";
		if (text ~= "") then
			return header .. text;
		end
	end
end

local function chatMsgLoot(...)
	local msg = ...;
    local amount;
    local name = UnitName("Player");
    local otherPlayer;
    --Self loot multiple item "You receive loot: [Item]x2"
	local itemLink, amount = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
	if (not itemLink) then
 		--Self receive single loot "You receive loot: [Item]"
    	itemLink = msg:match(LOOT_ITEM_SELF:gsub("%%s", "(.+)"));
		if (not itemLink) then
 			--Self receive single item "You receive item: [Item]"
			itemLink = msg:match(LOOT_ITEM_PUSHED_SELF:gsub("%%s", "(.+)"));
		end
    end
    if (itemLink) then
    	if (NIT.inInstance) then
	    	local itemID = string.match(itemLink, "item:(%d+)");
	    	if (itemID) then
	    		itemID = tonumber(itemID);
	    		if (itemID == 226404) then
	    			hideMiddleMsg();
	    			if (lastLootNpcID) then
	    				NIT:debug("Using lastLootNpcID:", lastBossNpcID);
			    		local resetTime = GetServerTime() + C_DateAndTime.GetSecondsUntilDailyReset();
						if (not NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID]) then
							NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID] = {};
						end
						if (not NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID].looted) then
							NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID].looted = {};
						end
						if (not NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID].resetTime or
								(NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID].resetTime < GetServerTime() - 300)) then
							NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID].resetTime = resetTime;
							NIT:debug("Missing boss kill reset time", lastLootNpcID); --Possiblly if a boss not on the list drops a token?
						end
						NIT.data.myChars[UnitName("player")].bossKills[lastLootNpcID].looted[itemID] = true;
					elseif (lastBossNpcID) then
						NIT:debug("Using backup lastBossNpcID:", lastBossNpcID);
						local resetTime = GetServerTime() + C_DateAndTime.GetSecondsUntilDailyReset();
						if (not NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID]) then
							NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID] = {};
						end
						if (not NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID].looted) then
							NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID].looted = {};
						end
						if (not NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID].resetTime or
								(NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID].resetTime < GetServerTime() - 300)) then
							NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID].resetTime = resetTime;
							NIT:debug("Missing boss kill reset time", lastBossNpcID); --Possiblly if a boss not on the list drops a token?
						end
						NIT.data.myChars[UnitName("player")].bossKills[lastBossNpcID].looted[itemID] = true;
					else
						NIT:debug("Loot ID error:", itemID, lastLootNpcID, lastBossNpcID);
					end
					lastLootNpcID = nil;
	    		end
	    	end
    	end
    end
end

local function lootOpened()
	--lastLootNpcID = nil; --Delete old ID on looting real instead.
	local sources = {GetLootSourceInfo(1)}
	--Always only 1 source in classic.
	local guid = sources[1];
	--Check loot sources first.
	if (guid) then
		local _, _, _, _, zoneID, npcID = strsplit("-", guid);
		if (npcID) then
			npcID = tonumber(npcID);
			if (npcID and turBosses[npcID]) then
				lastLootNpcID = npcID;
			end
		end
		return;
	end
	local guid = UnitGUID("target");
	--Check target as backup.
	if (guid) then
		local _, _, _, _, zoneID, npcID = strsplit("-", guid);
		if (npcID) then
			npcID = tonumber(npcID);
			if (npcID and turBosses[npcID]) then
				lastLootNpcID = npcID;
			end
		end
	end
end

--local function lootClosed()
	--It was unreliable removing the npcID when loot closed, it can close before the items are looted to your bags with auto loot.
	--And using a delay timer would be unreliable with ping I think.
	--Just clear the last npcID when loot is opened for now and see how reliable it is.
	--lastLootNpcID = nil;
--end

local function combatLogEventUnfiltered(...)
	local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, 
			destName, destFlags, destRaidFlags, _, spellName = CombatLogGetCurrentEventInfo();
	if (subEvent == "UNIT_DIED" and NIT.inInstance and destGUID and string.match(destGUID, "Creature")) then
		--If max level player then count mobs via death instead of xp.
		local _, _, _, _, zoneID, npcID = strsplit("-", destGUID);
		npcID = tonumber(npcID);
		local _, instanceType, difficultyID, _, _, _, _, instanceID = GetInstanceInfo();
		if (turBosses[npcID]) then
			if (dungeons[instanceID] and (not NIT.data.myChars[UnitName("player")].bossKills[npcID]
					or NIT.data.myChars[UnitName("player")].bossKills[npcID].resetTime < GetServerTime())) then
				addMsg(L["Loot the Tarnished Undermine Real"] .. "!", 10);
				local resetTime = GetServerTime() + C_DateAndTime.GetSecondsUntilDailyReset();
				if (not NIT.data.myChars[UnitName("player")].bossKills[npcID]) then
					NIT.data.myChars[UnitName("player")].bossKills[npcID] = {};
				end
				NIT.data.myChars[UnitName("player")].bossKills[npcID].resetTime = resetTime;
				lastBossNpcID = npcID;
				lastBossTime = GetServerTime();
			end
		end
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("CHAT_MSG_LOOT");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
f:RegisterEvent("LOOT_OPENED");
--f:RegisterEvent("LOOT_CLOSED");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "CHAT_MSG_LOOT") then
		chatMsgLoot(...);
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		combatLogEventUnfiltered(...);
	elseif (event == "LOOT_OPENED") then
		lootOpened();
	--elseif (event == "LOOT_CLOSED") then
	--	lootClosed();
	end
end)

function NIT:loadLootReminderListFrame()
	if (not lootReminderListFrame) then
		local frame = CreateFrame("Frame", "NITLootReminderListFrame", UIParent, "BackdropTemplate");
		frame.scrollFrame = CreateFrame("ScrollFrame", "$parentScrollFrame", frame, "UIPanelScrollFrameTemplate");
		--frame.scrollFrame:SetAllPoints();
		frame.scrollChild = CreateFrame("Frame", "$parentScrollChild", frame.scrollFrame);
		frame.scrollFrame:SetScrollChild(frame.scrollChild);
		--frame.scrollChild:SetWidth(frame:GetWidth() - 30);
		frame.scrollChild:SetAllPoints();
		frame.scrollChild:SetPoint("RIGHT", -40, 0);
		frame.scrollChild:SetPoint("TOP", 0, -20);
		frame.scrollChild:SetHeight(1);
		frame.scrollChild:SetScript("OnSizeChanged", function(self,event)
			frame.scrollChild:SetWidth(self:GetWidth())
		end)
		frame.scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -8);
		frame.scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 8);
		
		frame:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8",
			insets = {top = 4, left = 4, bottom = 4, right = 4},
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tileEdge = true,
			edgeSize = 16,
		});
		frame:SetBackdropColor(0, 0, 0, 0.9);
		frame:SetBackdropBorderColor(1, 1, 1, 0.7);
		frame.scrollFrame.ScrollBar:ClearAllPoints();
		frame.scrollFrame.ScrollBar:SetPoint("TOPRIGHT", -5, -(frame.scrollFrame.ScrollBar.ScrollDownButton:GetHeight()) + 1);
		frame.scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", -5, frame.scrollFrame.ScrollBar.ScrollUpButton:GetHeight());
		frame:SetToplevel(true);
		frame:SetMovable(true);
		frame:EnableMouse(true);
		frame:SetUserPlaced(false);
		frame:SetPoint("CENTER", UIParent, 0, 100);
		frame:SetSize(500, 670);
		frame:SetFrameStrata("HIGH");
		frame:SetFrameLevel(140);
		frame:SetScript("OnMouseDown", function(self, button)
			if (button == "LeftButton" and not self.isMoving) then
				self:StartMoving();
				self.isMoving = true;
			end
		end)
		frame:SetScript("OnMouseUp", function(self, button)
			if (button == "LeftButton" and self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
		frame:SetScript("OnHide", function(self)
			if (self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
		frame.scrollChild:EnableMouse(true);
		--frame.scrollChild:SetHyperlinksEnabled(true);
		--frame.scrollChild:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow);
		--Set all fonts in the module using the frame.
		--Header string.
		frame.scrollChild.fs = frame.scrollChild:CreateFontString("NITLootReminderListFrameFS", "ARTWORK");
		frame.scrollChild.fs:SetPoint("TOP", 0, -0);
		--The main display string.
		frame.scrollChild.fs2 = frame.scrollChild:CreateFontString("NITLootReminderListFrameFS2", "ARTWORK");
		frame.scrollChild.fs2:SetPoint("TOPLEFT", 10, -24);
		frame.scrollChild.fs2:SetJustifyH("LEFT");
		--Bottom string.
		frame.scrollChild.fs3 = frame.scrollChild:CreateFontString("NITLootReminderListFrameFS3", "ARTWORK");
		frame.scrollChild.fs3:SetPoint("BOTTOM", 0, -20);
		--frame.scrollChild.fs3:SetFont(NIT.regionFont, 14);
		--Top right X close button.
		frame.close = CreateFrame("Button", "NITLootReminderListFrameClose", frame, "UIPanelCloseButton");
		frame.close:SetPoint("TOPRIGHT", -22, -4);
		frame.close:SetWidth(20);
		frame.close:SetHeight(20);
		frame.close:SetScript("OnClick", function(self, arg)
			frame:Hide();
		end)
		frame.close:GetNormalTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetHighlightTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetPushedTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetDisabledTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame:SetFrameStrata("HIGH");
		frame:SetClampedToScreen(true);
		frame.scrollChild.fs:SetFont(NIT.regionFont, 14);
		--frame.scrollChild.fs2:SetFontObject(Game15Font);
		frame.scrollChild.fs2:SetFont(NIT.regionFont, 13);
		frame.scrollChild.fs3:SetFont(NIT.regionFont, 13);
		frame.scrollChild.fs:ClearAllPoints();
		frame.scrollChild.fs2:ClearAllPoints();
		frame.scrollChild.fs3:ClearAllPoints();
		frame.scrollChild.fs:SetPoint("TOP", 0, -5);
		frame.scrollChild.fs2:SetPoint("TOP", 0, -25);
		frame.scrollChild.fs3:SetPoint("TOPLEFT", 10, -48);
		frame.scrollChild.fs3:SetPoint("RIGHT", 0, -48);
		frame.scrollChild.fs3:SetJustifyH("LEFT");
		frame.scrollChild.fs3:CanWordWrap(true);
		frame.scrollChild.fs3:CanNonSpaceWrap(true);
		frame.scrollChild.fs3:SetNonSpaceWrap(true);
		frame.scrollChild.fs3:SetWordWrap(true);
		frame:Hide();
		lootReminderListFrame = frame;
	end
	lootReminderListFrame.scrollChild.fs:SetText("|cFFFFFFFFNIT Loot Reminder Daily List|r\n|cFF1EFF00[" .. L["Tarnished Undermine Real"] .. "]|r");
	local text = "\n";
	local count = 0;
	for instanceID, instanceName in NIT:pairsByKeys(dungeons) do
		count = count + 1;
		if (count == 1) then
			text = text .. "|cFFFFFF00" .. instanceName .. "|r";
		else
			text = text .. "\n\n|cFFFFFF00" .. instanceName .. "|r";
		end
		count = count + 1;
		local sorted = {};
		local lootedCount = 0;
		for k, v in pairs(turBosses) do
			if (v.instanceID == instanceID) then
				local t = {
					npcID = k,
					name = v.name,
					order = v.order,
					instanceID = v.instanceID,
					header = v.header,
					title = v.title,
				};
				tinsert(sorted, t);
			end
		end
		table.sort(sorted, function(a, b) return a.order < b.order end);
		for k, v in ipairs(sorted) do
			count = count + 1;
			if (v.header) then
				local headerString = "|cFF9CD6DE[" .. v.title  .. "]|r";
				if (count == 1) then
					text = text .. headerString;
				else
					text = text .. "\n" .. headerString;
				end
			else
				local looted, isKilledButNotLooted = getLootedStatus(v.npcID, 226404);
				local lootedString;
				if (isKilledButNotLooted) then
					lootedString = "|cFFFF6900(" .. L["Killed But Not Looted"] .. ")|r";
				elseif (looted) then
					lootedString = "|cFF00FF00(" .. L["Looted"] .. ")|r";
					lootedCount = lootedCount + 1;
				else
					lootedString = "|cFFFF0000(" .. L["Not Looted"] .. ")|r";
				end
				if (count == 1) then
					text = text .. "|cFFFFAE42".. v.name .. "|r  " .. lootedString;
				else
					text = text .. "\n|cFFFFAE42" .. v.name .. "|r  " .. lootedString;
				end
			end
		end
	end
	lootReminderListFrame.scrollChild.fs2:SetText(text);
	--newVersionFrame:SetSize(600, 50 + newVersionFrame.scrollChild.fs:GetStringHeight() + newVersionFrame.scrollChild.fs2:GetStringHeight() + newVersionFrame.scrollChild.fs3:GetStringHeight());
	lootReminderListFrame:Show();
end