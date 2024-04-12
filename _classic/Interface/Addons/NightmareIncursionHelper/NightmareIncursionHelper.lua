------------------------------
--Nightmare Incursion Helper--
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local addonName, NIH = ...;
_G["NIH"] = NIH;
local L = LibStub("AceLocale-3.0"):GetLocale("NightmareIncursionHelper");
NIH.dragonLib = LibStub("HereBeDragons-2.0");
local GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots;
local GetContainerItemID = GetContainerItemID or C_Container.GetContainerItemID;
local PickupContainerItem = PickupContainerItem or C_Container.PickupContainerItem;
local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID;
local GetItemCooldown = C_Container.GetItemCooldown;
local overlay, inbounds, deleteDuplicateID, autoOpened;
local shareQuestsCount, shareQuestsLeftCount, envelopeCount, deleteItemsCount, deleteQuestsCount = 0, 0, 0, 0, 0;

local function init()
    NIH.db = LibStub("AceDB-3.0"):New("NIHdatabase", NIH.optionDefaults, "Default");
    LibStub("AceConfig-3.0"):RegisterOptionsTable("NightmareIncursionHelper", NIH.options);
	NIH.NWBOptions = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NightmareIncursionHelper", "NightmareIncursionHelper");
end

function NIH:print(msg)
	print("|cFFFFFF00[NIH]|r |cFF9CD6DE" .. msg);
end

--Items in bags that can start a quest.
local startQuestItems = {
	[219999] = {name = "Nightmare Incursions: Ashenvale Mission I", questID = 81768},
	[220000] = {name = "Nightmare Incursions: Ashenvale Mission II", questID = 81769},
	[220001] = {name = "Nightmare Incursions: Ashenvale Mission III", questID = 81770},
	[220002] = {name = "Nightmare Incursions: Ashenvale Mission IV", questID = 81771},
	[220003] = {name = "Nightmare Incursions: Ashenvale Mission V", questID = 81772},
	[220004] = {name = "Nightmare Incursions: Ashenvale Mission VI", questID = 81773},
	[220005] = {name = "Nightmare Incursions: Ashenvale Mission VII", questID = 81774},
	[220006] = {name = "Nightmare Incursions: Ashenvale Mission VIII", questID = 81775},
	[220007] = {name = "Nightmare Incursions: Ashenvale Mission IX", questID = 81776},
	[220008] = {name = "Nightmare Incursions: Ashenvale Mission X", questID = 81777},
	[220009] = {name = "Nightmare Incursions: Ashenvale Mission XI", questID = 81778},
	[220010] = {name = "Nightmare Incursions: Ashenvale Mission XII", questID = 81779},
	[220011] = {name = "Nightmare Incursions: Ashenvale Mission XIII", questID = 81780},
	[220012] = {name = "Nightmare Incursions: Ashenvale Mission XIV", questID = 81781},
	[220013] = {name = "Nightmare Incursions: Ashenvale Mission XV", questID = 81782},
	[220014] = {name = "Nightmare Incursions: Ashenvale Mission XVI", questID = 81783},
	[220015] = {name = "Nightmare Incursions: Ashenvale Mission XVII", questID = 81784},
	[220016] = {name = "Nightmare Incursions: Ashenvale Mission XVIII", questID = 81785},
	
	[220035] = {name = "Nightmare Incursions: Feralas Mission I", questID = 81855},
	[220036] = {name = "Nightmare Incursions: Feralas Mission II", questID = 81856},
	[220037] = {name = "Nightmare Incursions: Feralas Mission III", questID = 81857},
	[220038] = {name = "Nightmare Incursions: Feralas Mission IV", questID = 81858},
	[220039] = {name = "Nightmare Incursions: Feralas Mission V", questID = 81859},
	[220040] = {name = "Nightmare Incursions: Feralas Mission VI", questID = 81860},
	[220041] = {name = "Nightmare Incursions: Feralas Mission VII", questID = 81861},
	[220042] = {name = "Nightmare Incursions: Feralas Mission VIII", questID = 81863},
	[220043] = {name = "Nightmare Incursions: Feralas Mission IX", questID = 81864},
	[220044] = {name = "Nightmare Incursions: Feralas Mission X", questID = 81865},
	[220045] = {name = "Nightmare Incursions: Feralas Mission XI", questID = 81866},
	[220046] = {name = "Nightmare Incursions: Feralas Mission XII", questID = 81867},
	[220047] = {name = "Nightmare Incursions: Feralas Mission XIII", questID = 81868},
	[220048] = {name = "Nightmare Incursions: Feralas Mission XIV", questID = 81870},
	[220049] = {name = "Nightmare Incursions: Feralas Mission XV", questID = 818671},
	[220050] = {name = "Nightmare Incursions: Feralas Mission XVI", questID = 81872},
	[220051] = {name = "Nightmare Incursions: Feralas Mission XVII", questID = 81873},
	[220052] = {name = "Nightmare Incursions: Feralas Mission XVIII", questID = 81874},
	
	[220017] = {name = "Nightmare Incursions: Hinterlands Mission I", questID = 81786},
	[220018] = {name = "Nightmare Incursions: Hinterlands Mission II", questID = 81787},
	[220019] = {name = "Nightmare Incursions: Hinterlands Mission III", questID = 81788},
	[220020] = {name = "Nightmare Incursions: Hinterlands Mission IV", questID = 81789},
	[220021] = {name = "Nightmare Incursions: Hinterlands Mission V", questID = 81817},
	[220022] = {name = "Nightmare Incursions: Hinterlands Mission VI", questID = 81820},
	[220023] = {name = "Nightmare Incursions: Hinterlands Mission VII", questID = 81826},
	[220024] = {name = "Nightmare Incursions: Hinterlands Mission VIII", questID = 81830},
	[220025] = {name = "Nightmare Incursions: Hinterlands Mission IX", questID = 81832},
	[220026] = {name = "Nightmare Incursions: Hinterlands Mission X", questID = 81833},
	[220027] = {name = "Nightmare Incursions: Hinterlands Mission XI", questID = 81834},
	[220028] = {name = "Nightmare Incursions: Hinterlands Mission XII", questID = 81835},
	[220029] = {name = "Nightmare Incursions: Hinterlands Mission XIII", questID = 81837},
	[220030] = {name = "Nightmare Incursions: Hinterlands Mission XIV", questID = 81838},
	[220031] = {name = "Nightmare Incursions: Hinterlands Mission XV", questID = 81839},
	[220032] = {name = "Nightmare Incursions: Hinterlands Mission XVI", questID = 81850},
	[220033] = {name = "Nightmare Incursions: Hinterlands Mission XVII", questID = 81851},
	[220034] = {name = "Nightmare Incursions: Hinterlands Mission XVIII", questID = 81852},
	
	[219962] = {name = "Nightmare Incursions: Duskwood Mission I", questID = 81730},
	[219966] = {name = "Nightmare Incursions: Duskwood Mission II", questID = 81731},
	[219967] = {name = "Nightmare Incursions: Duskwood Mission III", questID = 81732},
	[219968] = {name = "Nightmare Incursions: Duskwood Mission IV", questID = 81733},
	[219969] = {name = "Nightmare Incursions: Duskwood Mission V", questID = 81734},
	[219970] = {name = "Nightmare Incursions: Duskwood Mission VI", questID = 81735},
	[219971] = {name = "Nightmare Incursions: Duskwood Mission VII", questID = 81736},
	[219972] = {name = "Nightmare Incursions: Duskwood Mission VIII", questID = 81737},
	[219973] = {name = "Nightmare Incursions: Duskwood Mission IX", questID = 81738},
	[219974] = {name = "Nightmare Incursions: Duskwood Mission X", questID = 81739},
	[219975] = {name = "Nightmare Incursions: Duskwood Mission XI", questID = 81740},
	[219976] = {name = "Nightmare Incursions: Duskwood Mission XII", questID = 81741},
	[219977] = {name = "Nightmare Incursions: Duskwood Mission XIII", questID = 81742},
	[219978] = {name = "Nightmare Incursions: Duskwood Mission XIV", questID = 81743},
	[219979] = {name = "Nightmare Incursions: Duskwood Mission XV", questID = 81744},
	[219981] = {name = "Nightmare Incursions: Duskwood Mission XVI", questID = 81745},
	[219982] = {name = "Nightmare Incursions: Duskwood Mission XVII", questID = 81746},
	[219983] = {name = "Nightmare Incursions: Duskwood Mission XVIII", questID = 81747},
};

--Items in bags that share quests with other people when you target them.
local shareQuestItems = {
	[220053] = "Deputization Authorization: Ashenvale Mission I",
	[220054] = "Deputization Authorization: Ashenvale Mission II",
	[220055] = "Deputization Authorization: Ashenvale Mission III",
	[220056] = "Deputization Authorization: Ashenvale Mission IV",
	[220057] = "Deputization Authorization: Ashenvale Mission V",
	[220058] = "Deputization Authorization: Ashenvale Mission VI",
	[220059] = "Deputization Authorization: Ashenvale Mission VII",
	[220060] = "Deputization Authorization: Ashenvale Mission VIII",
	[220061] = "Deputization Authorization: Ashenvale Mission IX",
	[220062] = "Deputization Authorization: Ashenvale Mission X",
	[220063] = "Deputization Authorization: Ashenvale Mission XI",
	[220064] = "Deputization Authorization: Ashenvale Mission XII",
	[220065] = "Deputization Authorization: Ashenvale Mission XIII",
	[220066] = "Deputization Authorization: Ashenvale Mission XIV",
	[220067] = "Deputization Authorization: Ashenvale Mission XV",
	[220068] = "Deputization Authorization: Ashenvale Mission XVI",
	[220069] = "Deputization Authorization: Ashenvale Mission XVII",
	[220070] = "Deputization Authorization: Ashenvale Mission XVIII",
	
	[220089] = "Deputization Authorization: Feralas Mission I",
	[220090] = "Deputization Authorization: Feralas Mission II",
	[220091] = "Deputization Authorization: Feralas Mission III",
	[220092] = "Deputization Authorization: Feralas Mission IV",
	[220093] = "Deputization Authorization: Feralas Mission V",
	[220094] = "Deputization Authorization: Feralas Mission VI",
	[220095] = "Deputization Authorization: Feralas Mission VII",
	[220096] = "Deputization Authorization: Feralas Mission VIII",
	[220097] = "Deputization Authorization: Feralas Mission IX",
	[220098] = "Deputization Authorization: Feralas Mission X",
	[220099] = "Deputization Authorization: Feralas Mission XI",
	[2200100] = "Deputization Authorization: Feralas Mission XII",
	[2200101] = "Deputization Authorization: Feralas Mission XIII",
	[2200102] = "Deputization Authorization: Feralas Mission XIV",
	[2200103] = "Deputization Authorization: Feralas Mission XV",
	[2200104] = "Deputization Authorization: Feralas Mission XVI",
	[2200105] = "Deputization Authorization: Feralas Mission XVII",
	[2200106] = "Deputization Authorization: Feralas Mission XVIII",
	
	[220071] = "Deputization Authorization: Hinterlands Mission I",
	[220072] = "Deputization Authorization: Hinterlands Mission II",
	[220073] = "Deputization Authorization: Hinterlands Mission III",
	[220074] = "Deputization Authorization: Hinterlands Mission IV",
	[220075] = "Deputization Authorization: Hinterlands Mission V",
	[220076] = "Deputization Authorization: Hinterlands Mission VI",
	[220077] = "Deputization Authorization: Hinterlands Mission VII",
	[220078] = "Deputization Authorization: Hinterlands Mission VIII",
	[220079] = "Deputization Authorization: Hinterlands Mission IX",
	[220080] = "Deputization Authorization: Hinterlands Mission X",
	[220081] = "Deputization Authorization: Hinterlands Mission XI",
	[220082] = "Deputization Authorization: Hinterlands Mission XII",
	[220083] = "Deputization Authorization: Hinterlands Mission XIII",
	[220084] = "Deputization Authorization: Hinterlands Mission XIV",
	[220085] = "Deputization Authorization: Hinterlands Mission XV",
	[220086] = "Deputization Authorization: Hinterlands Mission XVI",
	[220087] = "Deputization Authorization: Hinterlands Mission XVII",
	[220088] = "Deputization Authorization: Hinterlands Mission XVIII",
	
	[219963] = "Deputization Authorization: Duskwood Mission I",
	[219965] = "Deputization Authorization: Duskwood Mission II",
	[219983] = "Deputization Authorization: Duskwood Mission III",
	[219984] = "Deputization Authorization: Duskwood Mission IV",
	[219985] = "Deputization Authorization: Duskwood Mission V",
	[219986] = "Deputization Authorization: Duskwood Mission VI",
	[219987] = "Deputization Authorization: Duskwood Mission VII",
	[219988] = "Deputization Authorization: Duskwood Mission VIII",
	[219989] = "Deputization Authorization: Duskwood Mission IX",
	[219990] = "Deputization Authorization: Duskwood Mission X",
	[219991] = "Deputization Authorization: Duskwood Mission XI",
	[219992] = "Deputization Authorization: Duskwood Mission XII",
	[219993] = "Deputization Authorization: Duskwood Mission XIII",
	[219994] = "Deputization Authorization: Duskwood Mission XIV",
	[219995] = "Deputization Authorization: Duskwood Mission XV",
	[219996] = "Deputization Authorization: Duskwood Mission XVI",
	[219997] = "Deputization Authorization: Duskwood Mission XVII",
	[219998] = "Deputization Authorization: Duskwood Mission XVIII",
};

--First starter quest envelopes.
local missionBriefs = {
	[219773] = "Mission Brief: Ashenvale",
	[219775] = "Mission Brief: Feralas",
	[219526] = "Mission Brief: Duskwood",
	[219774] = "Mission Brief: Hinterlands",
};

--QuestIDs and quest type.
local quests = {
	[81768] = {name = "Ashenvale Mission I: Defeat Satyrs", type = "kill"},
	[81769] = {name = "Ashenvale Mission II: Defeat Treants", type = "kill"},
	[81770] = {name = "Ashenvale Mission III: Defeat Dragonkin", type = "kill"},
	[81771] = {name = "Ashenvale Mission IV: Dragon Intelligence", type = "item"},
	[81772] = {name = "Ashenvale Mission V: Satyr Intelligence", type = "item"},
	[81773] = {name = "Ashenvale Mission VI: Treant Intelligence", type = "item"},
	[81774] = {name = "Ashenvale Mission VII: Recover Dreamengine", type = "item"},
	[81775] = {name = "Ashenvale Mission VIII: Recover Azsharan Prophecy", type = "item"},
	[81776] = {name = "Ashenvale Mission IX: Recover Dream-Touched Dragonegg", type = "item"},
	[81777] = {name = "Ashenvale Mission X: Dreamroot", type = "gathering"},
	[81778] = {name = "Ashenvale Mission XI: Fool's Gold Dust", type = "gathering"},
	[81779] = {name = "Ashenvale Mission XII: Dream-Infused Dragonscale", type = "gathering"},
	[81780] = {name = "Ashenvale Mission XIII: Defeat Larsera", type = "kill"},
	[81781] = {name = "Ashenvale Mission XIV: Defeat Zalius", type = "kill"},
	[81782] = {name = "Ashenvale Mission XV: Defeat Shredder 9000", type = "kill"},
	[81783] = {name = "Ashenvale Mission XVI: Rescue Alyssian Windcaller", type = "escort"},
	[81784] = {name = "Ashenvale Mission XVII: Rescue Doran Dreambough", type = "escort"},
	[81785] = {name = "Ashenvale Mission XVIII: Rescue Maseara Autumnmoon", type = "escort"},
	
	[81855] = {name = "Feralas Mission I: Defeat Children of Cenarius", type = "kill"},
	[81856] = {name = "Feralas Mission II: Defeat Harpies", type = "kill"},
	[81857] = {name = "Feralas Mission III: Defeat Dragonkin", type = "kill"},
	[81858] = {name = "Feralas Mission IV: Dragon Intelligence", type = "kill"},
	[81859] = {name = "Feralas Mission V: Cenarion Intelligence", type = "item"},
	[81860] = {name = "Feralas Mission VI: Harpy Intelligence", type = "item"},
	[81861] = {name = "Feralas Mission VII: Recover Moonglow Dragonegg", type = "item"},
	[81863] = {name = "Feralas Mission VIII: Recover Keeper's Notes", type = "item"},
	[81864] = {name = "Feralas Mission IX: Recover Harpy Screed", type = "item"},
	[81865] = {name = "Feralas Mission X: Moonroot", type = "gathering"},
	[81866] = {name = "Feralas Mission XI: Greater Moonstone", type = "gathering"},
	[81867] = {name = "Feralas Mission XII: Greater Moondragon Scales", type = "gathering"},
	[81868] = {name = "Feralas Mission XIII: Defeat Tyrannikus", type = "kill"},
	[81870] = {name = "Feralas Mission XIV: Defeat Alondrius", type = "kill"},
	[81871] = {name = "Feralas Mission XV: Defeat Slirena", type = "kill"},
	[81872] = {name = "Feralas Mission XVI: Rescue Mellias Earthtender", type = "escort"},
	[81873] = {name = "Feralas Mission XVII: Rescue Nerene Brooksinger", type = "escort"},
	[81874] = {name = "Feralas Mission XVIII: Rescue Jamniss Treemender", type = "escort"},
	
	[81786] = {name = "Hinterlands Mission I: Defeat Moonkin", type = "kill"},
	[81787] = {name = "Hinterlands Mission II: Defeat Giant Turtles", type = "kill"},
	[81788] = {name = "Hinterlands Mission III: Defeat Dragonkin", type = "kill"},
	[81789] = {name = "Hinterlands Mission IV: Dragon Intelligence", type = "item"},
	[81817] = {name = "Hinterlands Mission V: Turtle Intelligence", type = "item"},
	[81820] = {name = "Hinterlands Mission VI: Moonkin Intelligence", type = "item"},
	[81826] = {name = "Hinterlands Mission VII: Recover Star-Touched Dragonegg", type = "item"},
	[81830] = {name = "Hinterlands Mission VIII: Recover Elunar Relic", type = "item"},
	[81832] = {name = "Hinterlands Mission IX: Recover Dreampearl", type = "item"},
	[81833] = {name = "Hinterlands Mission X: Star Lotus", type = "gathering"},
	[81834] = {name = "Hinterlands Mission XI: Starsilver Ore", type = "gathering"},
	[81835] = {name = "Hinterlands Mission XII: Starshells", type = "gathering"},
	[81837] = {name = "Hinterlands Mission XIII: Defeat Florius", type = ""},
	[81838] = {name = "Hinterlands Mission XIV: Defeat Doomkin", type = ""},
	[81839] = {name = "Hinterlands Mission XV: Defeat Ghamoo-Raja", type = ""},
	[81850] = {name = "Hinterlands Mission XVI: Rescue Elianar Shadowdrinker", type = ""},
	[81851] = {name = "Hinterlands Mission XVII: Rescue Serlina Starbright", type = ""},
	[81852] = {name = "Hinterlands Mission XVIII: Rescue Veanna Cloudsleeper", type = ""},
	
	[81730] = {name = "Duskwood Mission I: Defeat Worgen", type = "kill"},
	[81731] = {name = "Duskwood Mission II: Defeat Ogres", type = "kill"},
	[81732] = {name = "Duskwood Mission III: Defeat Dragonkin", type = "kill"},
	[81733] = {name = "Duskwood Mission IV: Ogre Intelligence", type = "item"},
	[81734] = {name = "Duskwood Mission V: Worgen Intelligence", type = "item"},
	[81735] = {name = "Duskwood Mission VI: Dragon Intelligence", type = "item"},
	[81736] = {name = "Duskwood Mission VII: Recover Shadowscythe", type = "item"},
	[81737] = {name = "Duskwood Mission VIII: Recover Ogre Magi text", type = "item"},
	[81738] = {name = "Duskwood Mission IX: Recover Dragon Egg", type = "item"},
	[81739] = {name = "Duskwood Mission X: Nightmare Moss", type = "gathering"},
	[81740] = {name = "Duskwood Mission XI: Cold Iron Ore", type = "gathering"},
	[81741] = {name = "Duskwood Mission XII: Dream-Touched Dragonscale", type = "gathering"},
	[81742] = {name = "Duskwood Mission XIII: Defeat Ylanthrius", type = "kill"},
	[81743] = {name = "Duskwood Mission XIV: Defeat Vvarc'zul", type = "kill"},
	[81744] = {name = "Duskwood Mission XV: Defeat Amokarok", type = "kill"},
	[81745] = {name = "Duskwood Mission XVI: Rescue Kroll Mountainshade", type = "escort"},
	[81746] = {name = "Duskwood Mission XVII: Rescue Alara Grovemender", type = "escort"},
	[81747] = {name = "Duskwood Mission XVIII: Rescue Elenora Marshwalker", type = "escort"},
};

--Ignore the first starter quest so we don't fill a quest slot once we get going.
local ignoredAutoQuests = {
	[81716] = true, --Recover Incursion Field Report: Duskwood
	[81727] = true, --Recover Incursion Field Report: Ashenvale
	[81728] = true, --Recover Incursion Field Report: Hinterlands
	[81729] = true, --Recover Incursion Field Report: Feralas
};

--NPCs outside the incursion that give first starter quest.
local questNpcs = {
	[221471] = true, --Field Captain Palandar (Duskwood).
	[221477] = true, --Field Captain Hannalah (Ashenvale).
	[221479] = true, --Field Captain Korlian (Hinterlands).
	[221480] = true, --Field Captain Arunnel (Feralas).
};

--NPCs inside the incursion that give you intel reports, and escort npcs.
local autoDialogueNpcs = {
	--Ashenvale.
	[221271] = true, --Dreamwarden Ellodar.
	[221272] = true, --Dreamwarden Mandoran.
	[221273] = true, --Dreamwarden Lanaria.
	[221270] = true, --Alyssian Windcaller.
	[221268] = true, --Doran Dreambough.
	[221269] = true, --Maseara Autumnmoon.
	--Feralas.
	[221401] = true, --Dreamwarden Sheldryn.
	[221402] = true, --Dreamwarden Gorlas.
	[221404] = true, --Dreamwarden Anadelle.
	[221395] = true, --Mellias Earthtender.
	[221398] = true, --Nerene Brooksinger.
	[221399] = true, --Jamniss Treemender.
	--Duskwood.
	[221222] = true, --Dreamwarden Thalinar.
	[221220] = true, --Dreamwarden Amalia.
	[221221] = true, --Dreamwarden Dorilar.
	[221210] = true, --Kroll Mountainshade.
	[221215] = true, --Alara Grovemender.
	[221216] = true, --Elenora Marshwalker.
	--Hinterlands.
	[221401] = true, --Dreamwarden Sheldryn.
	[221402] = true, --Dreamwarden Gorlas.
	[221404] = true, --Dreamwarden Anadelle.
	[221335] = true, --Elianar Shadowdrinker.
	[221336] = true, --Serlina Starbright.
	[221337] = true, --Veanna Cloudsleeper.
};

--Zones with bounding box coords where incursions are.
local incursionZones = {
	[1440] = {left = 0.87, right = 1, top = 0, bottom = 0.46}, --Ashenvale.
	[1444] = {left = 0.47, right = 0.53, top = 0.09, bottom = 0.15}, --Feralas.
	[1425] = {left = 0.59, right = 0.68, top = 0, bottom = 0.34}, --Hinterlands.
	[1431] = {left = 0.43, right = 0.55, top = 0.29, bottom = 0.60}, --Duskwood.
};

--Larger area, we keep the overlay up in the whole area when inside instead of just the npc/portal.
local incursionZonesLarge = {
	[1440] = {left = 0.78, right = 1, top = 0, bottom = 0.64},
	[1444] = {left = 0.47, right = 0.53, top = 0.09, bottom = 0.15},
	[1425] = {left = 0.43, right = 0.78, top = 0, bottom = 0.60},
	[1431] = {left = 0.27, right = 0.73, top = 0.29, bottom = 0.84},
};

local deleteItems = {
	--Structure: [0] = {name = "Mission Brief: Test", type = 1},
};

local function updateQuestsTitle()
	local count = 0;
	for i = 1, GetNumQuestLogEntries() do
		local _, _, _, _, _, _, _, questID = GetQuestLogTitle(i);
		if (questID and quests[questID]) then
			count = count + 1;
		end
	end
	overlay.fs:SetText("|cFF00FF00------ " .. L["Quests"] .. " |cFFFFFF00" .. count .. "|r ------");
end

--Add items we want to delete, and assign a type to check vs config.
for k, v in pairs(startQuestItems) do
	v.type = 2;
	deleteItems[k] = v;
end

for k, v in pairs(shareQuestItems) do
	local t = {
		name = v,
		type = 3,
	};
	deleteItems[k] = t;
end

for k, v in pairs(missionBriefs) do
	local t = {
		name = v,
		type = 1,
	};
	deleteItems[k] = t;
end

--Credit to Roadblock for the startQuests and lootItem updates.
local function startQuests()
    if (InCombatLockdown()) then
    	return;
    end
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemID = GetContainerItemID(bag, slot);
            if (itemID) then
                local questStarter = startQuestItems[itemID];
                if (questStarter) then
                    if (not C_QuestLog.IsOnQuest(questStarter.questID)) then
                        C_Container.UseContainerItem(bag, slot);
                    end
                end
            end
        end
    end
end

--Delete duplicate items and start quests as they're looted.
--Even though this is called after /use envelope runs before the actual loot window opens due to server query.
function NIH_OE()
    if (deleteDuplicateID and startQuestItems[deleteDuplicateID] or shareQuestItems[deleteDuplicateID]) then
    	for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
	  			local itemID = GetContainerItemID(bag,slot);
				if (itemID == deleteDuplicateID) then
					local name, itemLink = GetItemInfo(itemID);
					PickupContainerItem(bag,slot)
					DeleteCursorItem();
					if (itemLink) then
						NIH:print("|cFFFF6900Deleted Duplicate Quest: " .. itemLink .. "");
					elseif (name) then
						NIH:print("|cFFFF6900Deleted Duplicate Quest:|r [" .. name .. "]");
					else
						NIH:print("|cFFFF6900Deleted Duplicate Quest: Unknown item name for item ID: " .. itemID .. ".");
					end
				end
			end
        end
    end
    deleteDuplicateID = nil;
	startQuests();
end

--If we have a duplicate then close window and set next click to delete duplicate then reloot.
local function lootItem(...)
	if (not overlay:IsShown()) then
		NIH_AO = nil;
		deleteDuplicateID = nil;
		return;
	end
	deleteDuplicateID = nil;
	local found;
    for slot = GetNumLootItems(), 1, -1 do
        local itemLink = GetLootSlotLink(slot);
        if (itemLink) then
            local itemID = tonumber(itemLink:match("Hitem:(%d+)"));
            if (itemID and (startQuestItems[itemID] or shareQuestItems[itemID])) then
            	--Check if we have a duplicate in bags already;
            	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
	            	for slot = 1, GetContainerNumSlots(bag) do
			  			local deleteID = GetContainerItemID(bag,slot);
						if (itemID == deleteID) then
							found = true;
							deleteDuplicateID = itemID;
							if (NIH_AO and LootFrame:IsShown()) then
								C_Timer.After(0.001, function()
									CloseLoot();
									NIH_AO = nil;
								end)
								NIH:print("|cFFFF6900Duplicate quest found, press button again to delete old and loot new.");
							end
							ConfirmLootSlot(slot);
			                local dialog = StaticPopup_FindVisible("LOOT_BIND");
			                if (dialog) then
			                	_G[dialog:GetName().."Button1"]:Click();
			                end
						end
					end
				end
				if (not found) then
	                LootSlot(slot);
	                ConfirmLootSlot(slot);
	                local dialog = StaticPopup_FindVisible("LOOT_BIND");
	                if (dialog) then
	                	_G[dialog:GetName().."Button1"]:Click();
	                end
                end
            end
        end
    end
    if (not found) then
	    NIH_AO = nil;
    end
    --If loot window manually opened clear stuff we would do on next click.
    if (not NIH_AO) then
    	deleteDuplicateID = nil;
    end
end

--[[local function lootItem(...)
    for slot = GetNumLootItems(), 1, -1 do
        local itemLink = GetLootSlotLink(slot);
        if (itemLink) then
            local itemID = tonumber(itemLink:match("Hitem:(%d+)"));
            if (itemID and (startQuestItems[itemID] or shareQuestItems[itemID])) then
                LootSlot(slot);
                ConfirmLootSlot(slot);
                local dialog = StaticPopup_FindVisible("LOOT_BIND");
                if (dialog) then
                	_G[dialog:GetName().."Button1"]:Click();
                end
            end
        end
    end
end]]

local shareQuestsData = {};
local cycleActive;
local function createShareQuestsData()
	startQuests();
	if (not IsInGroup()) then
		NIH:print("You need to be in a group and people need to be close in range to share quests.");
		return;
	end
	shareQuestsData = {};
	local groupCount, questCount = 0, 0;
	local me = UnitName("player");
	for i = 1, GetNumGroupMembers() do
		local name, _, _, _, _, class = GetRaidRosterInfo(i);
		local realm;
		if (name and name ~= me) then
			local found;
			local t = {
				name = name,
				class = class,
			};
			for bag = 0, NUM_BAG_SLOTS do
				for slot = 1, GetContainerNumSlots(bag) do
		  			local itemID = GetContainerItemID(bag,slot);
					if (itemID and shareQuestItems[itemID]) then
						local itemName = GetItemInfo(itemID);
						local tt = {
							itemName = itemName;
						};
						tinsert(t, tt);
						questCount = questCount + 1;
						found = true;
					end
				end
			end
			if (found) then
				groupCount = groupCount + 1;
				tinsert(shareQuestsData, t);
			end
		end
	end
	shareQuestsCount = questCount;
	if (next(shareQuestsData)) then
		NIH:print("Loaded |cFFFFFF00" .. groupCount .. "|r party members (total of |cFFFFFF00" .. questCount .. "|r quests to share), click \"" .. L["Share Quests"] .. "\" button to start cycling through each player and quest.");
	else
		NIH:print("No incursion quest items found in bags to share.");
	end
end

local function clearShareQuestsData()
	shareQuestsData = {};
end

local function updateShareQuestsButton()
	if (InCombatLockdown()) then
		NIH:print("This can't be used in combat.");
		return;
	end
	local name, class, itemName;
	local count = 0;
	if (not next(shareQuestsData)) then
		overlay.button2:SetText(L["Share Quests"] .. " (" .. count .. ")");
		overlay.fs2:SetText("Player: --" );
		overlay.fs3:SetText("Item: --");
		overlay.button2:Disable();
		cycleActive = false;
	else
		for k, v in ipairs(shareQuestsData) do
			if (not name) then
				name = v.name;
				class = v.class;
				for kk, questItem in ipairs(v) do
					itemName = questItem.itemName;
					table.remove(v, kk);
					break;
				end
			end
			for kk, questItem in ipairs(v) do
				count = count + 1;
			end
		end
		count = count + 1;
		if (name and itemName) then
			local nameText;
			if (class) then
				local _, _, _, classColorHex = GetClassColor(class);
				nameText = "|c" .. classColorHex .. name .. "|r";
			else
				nameText = name;
			end
			overlay.button2:SetAttribute("macrotext", "/targetexact " .. name .. "\n/use " .. itemName .. "\n/stopspelltarget\n/run NIH_UpdateQuestsButton()");
			overlay.fs2:SetText("Player: " .. nameText);
			overlay.fs3:SetText("Item: |cFF1EFF00[" .. itemName .. "]|r");
			cycleActive = true;
		end
		--If first table entry is empty remove it, move on to next player.
		if (not shareQuestsData[1][1]) then
			table.remove(shareQuestsData, 1);
		end
		overlay.button2:SetText(L["Share Quests"] .. " (" .. count .. ")");
	end
	shareQuestsLeftCount = count;
	if (count == 0) then
		overlay.button2:Disable();
	else
		overlay.button2:Enable();
	end
end

function NIH_UpdateQuestsButton()
	updateShareQuestsButton();
end

--Open envelopes that contain new quests.
local function updateOpenEnvelopesButton()
	local name, itemName;
	local count = 0;
	for bag = 0, NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bag) do
  			local itemID = GetContainerItemID(bag,slot)
			if (itemID and missionBriefs[itemID]) then
				count = count + 1;
			end
		end
	end
	envelopeCount = count;
	overlay.button3:SetText(L["Open Envelopes"] .. " (" .. count .. ")");
end

--Delete old quest items.
local function updateDeleteButton()
	local count = 0;
	local db = NIH.db.global;
	for bag = 0, NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bag) do
  			local itemID = GetContainerItemID(bag,slot)
			if (itemID and deleteItems[itemID]) then
				local data = deleteItems[itemID];
				if ((data.type == 1 and db.deleteItemsMissionBrief) or (data.type == 2 and db.deleteItemsQuestStart)
					or (data.type == 3 and db.deleteItemsDeputize)) then
					count = count + 1;
				end
			end
		end
	end
	deleteItemsCount = count;
	overlay.button4:SetText(L["Delete Items"] .. " (" .. count .. ")");
end

local function deleteItem()
	local deleted;
	local db = NIH.db.global;
	for bag = 0, NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bag) do
  			local itemID = GetContainerItemID(bag,slot)
			if (itemID and deleteItems[itemID]) then
				local data = deleteItems[itemID];
				if ((data.type == 1 and db.deleteItemsMissionBrief) or (data.type == 2 and db.deleteItemsQuestStart)
					or (data.type == 3 and db.deleteItemsDeputize)) then
					local name, itemLink = GetItemInfo(itemID);
					--API was changed to only allow one item to be deleted.
					if (not deleted) then
						PickupContainerItem(bag,slot)
						DeleteCursorItem();
						if (itemLink) then
							NIH:print("|cFFFF6900Deleted Item: " .. itemLink .. "");
						elseif (name) then
							NIH:print("|cFFFF6900Deleted Item:|r [" .. name .. "]");
						else
							NIH:print("|cFFFF6900Deleted Item: Unknown item name for item ID: " .. itemID .. ".");
						end
						deleted = true;
					end
				end
			end
		end
	end
	updateDeleteButton();
end

--Delete quests.
local questsToDelete = {};
local function updateDeleteQuestsButton()
	local count = 0
	for i = 1, GetNumQuestLogEntries() do
        local questName, _, _, _, _, _, _, questID = GetQuestLogTitle(i);
        if (questID and questsToDelete[questID]) then
            count = count + 1;
        end
    end
    deleteQuestsCount = count;
	overlay.button5:SetText(L["Delete Quests"] .. " (" .. count .. ")");
end

local function loadQuestsToDelete()
	local deleteQuestsGathering = NIH.db.global.deleteQuestsGathering;
	local deleteQuestsKill = NIH.db.global.deleteQuestsKill;
	local deleteQuestsPickupItem = NIH.db.global.deleteQuestsPickupItem;
	local deleteQuestsEscort = NIH.db.global.deleteQuestsEscort;
	local deleteQuestsAll = NIH.db.global.deleteQuestsAll;
	questsToDelete = {};
	for k, v in pairs(quests) do
		if (deleteQuestsGathering and v.type == "gathering") then
			questsToDelete[k] = v.type;
		end
		if (deleteQuestsKill and v.type == "kill") then
			questsToDelete[k] = v.type;
		end
		if (deleteQuestsPickupItem and v.type == "item") then
			questsToDelete[k] = v.type;
		end
		if (deleteQuestsEscort and v.type == "escort") then
			questsToDelete[k] = v.type;
		end
		if (deleteQuestsAll) then
			questsToDelete[k] = v.type;
		end
	end
end

local function deleteQuests()
	for i = 1, GetNumQuestLogEntries() do
		local name, level, _, _, _, _, _, questID = GetQuestLogTitle(i);
		if (questID and questsToDelete[questID]) then
			local color = GetQuestDifficultyColor(level);
			SelectQuestLogEntry(i);
			SetAbandonQuest();
			AbandonQuest();
			if (color) then
				local hex = NIH:RGBToHex(color.r, color.g, color.b);
				NIH:print("|cFFFF6900Deleted quest:|r |cFF" .. hex .. "[" .. name .. "]");
			else
				NIH:print("Deleted quest: |cFFFFFF00[" .. name .. "]");
			end
		end
	end
end

--Just messing with a display type overlay for speed runs here, ashenvale only for now.
local questLogData = {
	[81768] = {name = "Defeat Satyrs", type = "kill"},
	[81769] = {name = "Defeat Treants", type = "kill"},
	[81770] = {name = "Defeat Dragonkin", type = "kill"},
	[81771] = {name = "Dragon Intelligence", type = "item"},
	[81772] = {name = "Satyr Intelligence", type = "item"},
	[81773] = {name = "Treant Intelligence", type = "item"},
	[81774] = {name = "Recover Dreamengine", type = "item"},
	[81775] = {name = "Recover Azsharan Prophecy", type = "item"},
	[81776] = {name = "Recover Dream-Touched Dragonegg", type = "item"},
	[81777] = {name = "Dreamroot", type = "gathering"},
	[81778] = {name = "Fool's Gold Dust", type = "gathering"},
	[81779] = {name = "Dream-Infused Dragonscale", type = "gathering"},
	[81780] = {name = "Defeat Larsera", type = "kill"},
	[81781] = {name = "Defeat Zalius", type = "kill"},
	[81782] = {name = "Defeat Shredder 9000", type = "kill"},
	[81783] = {name = "Rescue Alyssian Windcaller", type = "escort"},
	[81784] = {name = "Rescue Doran Dreambough", type = "escort"},
	[81785] = {name = "Rescue Maseara Autumnmoon", type = "escort"},
};

local function updateQuestLog()
	if (NIH.db.global.showQuestLog) then
		overlay.questLog:Show();
	else
		overlay.questLog:Hide();
	end
	local gathering = NIH.db.global.questLogGathering;
	local kill = NIH.db.global.questLogKill;
	local pickupItem = NIH.db.global.questLogPickupItem;
	local escort = NIH.db.global.questLogEscort;
	local questsToShow = {};
	for k, v in pairs(questLogData) do
		if (gathering and v.type == "gathering") then
			questsToShow[k] = v;
		end
		if (kill and v.type == "kill") then
			questsToShow[k] = v;
		end
		if (pickupItem and v.type == "item") then
			questsToShow[k] = v;
		end
		if (escort and v.type == "escort") then
			questsToShow[k] = v;
		end
	end
	local fs = overlay.questLog.fs;
	local fs2 = overlay.questLog.fs2;
	for k, v in pairs(fs) do
		v:Hide();
		v:ClearAllPoints();
	end
	for k, v in pairs(fs2) do
		v:Hide();
		v:ClearAllPoints();
	end
	local startOffset, padding = 5, 11;
	local width, height = 0, 0;
	local count = 0;
	local found;
	for k, v in NIH:pairsByKeys(questsToShow) do
		if (C_QuestLog.IsOnQuest(k)) then
			local displayName = v.name;
			local localizedName = C_QuestLog.GetQuestInfo(k);
			if (localizedName and localizedName ~= "") then
				--Hopefully most languages seperate this quets string with a colon.
				local shortened = strmatch(localizedName, ": (.*)");
				if (shortened) then
					displayName = shortened;
				end
			end
			count = count + 1;
			local text = "|cFFFFFF00" .. displayName;
			if (IsQuestComplete(k)) then
				local texture = "|TInterface\\Buttons\\UI-CheckBox-Check-Disabled:19:19:0:0:1:1:0:1:0:1:0:255:0|t"
				fs2[count]:SetText(texture);
			else
				fs2[count]:SetText("");
			end
			fs[count]:SetText(text);
			if (count == 1) then
				fs[count]:SetPoint("TOPLEFT", 10, -startOffset);
				fs2[count]:SetPoint("TOPLEFT", -4, -startOffset);
			else
				fs[count]:SetPoint("TOPLEFT", 10, -(startOffset + (padding * (count - 1))));
				fs2[count]:SetPoint("TOPLEFT", -4, -(startOffset + (padding * (count - 1))));
			end
			if (fs[count]:GetWidth() > width) then
				width = fs[count]:GetWidth();
			end
			height = height + fs[count]:GetHeight() + 1;
			found = true;
			fs[count]:Show();
			fs2[count]:Show();
		end
	end
	overlay.questLog.counter:SetText("|cFF00FF00(" .. count .. ")");
	if (not found) then
		overlay.questLog:Hide();
	else
		overlay.questLog:SetWidth(width + 10);
		overlay.questLog:SetHeight(height + 4);
	end
end

local overlayManuallyClosed, overlayManuallyOpened = false, false;
local function loadOverlay()
	if (not overlay) then
		local frame = CreateFrame("Frame", "NIH_Overlay", UIParent);
		frame:Hide();
		frame:SetFrameLevel(8);
		frame.background = CreateFrame("Frame", "NIH_OverlayBackground", frame, "BackdropTemplate");	
		frame.background:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8",
		});
		frame.background:SetBackdropColor(0, 0, 0);
		frame.background:SetAlpha(0.5);
		frame.background:SetAllPoints();
		frame.background:SetFrameLevel(7);
		frame:SetMovable(true);
		frame:EnableMouse(true);
		frame:SetUserPlaced(false);
		if (NIH.db.global[frame:GetName() .. "_point"]) then
			frame.ignoreFramePositionManager = true;
			frame:ClearAllPoints();
			frame:SetPoint(NIH.db.global[frame:GetName() .. "_point"], nil, NIH.db.global[frame:GetName() .. "_relativePoint"],
					NIH.db.global[frame:GetName() .. "_x"], NIH.db.global[frame:GetName() .. "_y"]);
			frame:SetUserPlaced(false);
		else
			frame:SetPoint("CENTER", UIParent, 0, 100);
		end
		frame:SetSize(175, 250);
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
				frame:SetUserPlaced(false);
				NIH.db.global[frame:GetName() .. "_point"], _, NIH.db.global[frame:GetName() .. "_relativePoint"], 
						NIH.db.global[frame:GetName() .. "_x"], NIH.db.global[frame:GetName() .. "_y"] = frame:GetPoint();
			end
		end)
		frame:SetScript("OnHide", function(self)
			if (self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
		--frame.lastUpdate = 0;
		--[[frame:SetScript("OnUpdate", function(self)
			--Update throddle.
			if (GetTime() - frame.lastUpdate > 1) then
				frame.lastUpdate = GetTime();
				updateOverlay();
			end
		end)]]
		--[[frame:SetScript("OnEnter", function(self)
			frame.background:SetAlpha(0.5);
		end);
		frame:SetScript("OnLeave", function(self)
			frame.background:SetAlpha(0);
		end);]]
		--frame:SetFrameStrata("HIGH");
		frame:SetClampedToScreen(true);
		frame.fsTitle = frame:CreateFontString("NIH_OverlayFSTitle", "ARTWORK");
		frame.fsTitle:SetPoint("TOPLEFT", 0, -2);
		frame.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 9.5, "OUTLINE");
		frame.fsTitle:SetText("|cFFFFFF00" .. L["Nightmare Incursion Helper"]);
		
		frame.fs = frame:CreateFontString("NIH_OverlayFS", "ARTWORK");
		frame.fs:SetPoint("TOP", 0, -18);
		frame.fs:SetFont("Fonts\\FRIZQT__.ttf", 11, "OUTLINE");
		frame.fs:SetText("|cFF00FF00--------- " .. L["Quests"] .. " ---------");
		
		frame.fs2 = frame:CreateFontString("NIH_OverlayFS2", "ARTWORK");
		frame.fs2:SetPoint("TOPLEFT", 5, -65);
		frame.fs2:SetFont("Fonts\\FRIZQT__.ttf", 11, "OUTLINE");
		
		frame.fs3 = frame:CreateFontString("NIH_OverlayFS3", "ARTWORK");
		frame.fs3:SetPoint("TOPLEFT", 5, -85);
		frame.fs3:SetFont("Fonts\\FRIZQT__.ttf", 11, "OUTLINE");
		
		frame.fs4 = frame:CreateFontString("NIH_OverlayFS4", "ARTWORK");
		frame.fs4:SetPoint("TOP", 0, -137);
		frame.fs4:SetFont("Fonts\\FRIZQT__.ttf", 11, "OUTLINE");
		frame.fs4:SetText("|cFF00FF00------- " .. L["Envelopes"] .. " -------");
		
		frame.fs5 = frame:CreateFontString("NIH_OverlayFS4", "ARTWORK");
		frame.fs5:SetPoint("TOP", 0, -185);
		frame.fs5:SetFont("Fonts\\FRIZQT__.ttf", 11, "OUTLINE");
		frame.fs5:SetText("|cFFFF6900--------- " .. L["Delete"] .. " ---------");
		
		frame.macroButton = CreateFrame("Button", "NIHMacroButton", UIParent, "InsecureActionButtonTemplate");
		frame.macroButton:SetAttribute("type", "macro");
		
		frame.button = CreateFrame("Button", "$parentButton1", frame, "UIPanelButtonTemplate");
		frame.button:SetPoint("TOP", 0, -35);
		frame.button:SetWidth(150);
		frame.button:SetText(L["Start (Load Quests)"]);
		frame.button:RegisterForClicks("LeftButtonDown", "RightButtonDown");
		frame.button:SetScript("OnClick", function(self, arg)
			if (arg == "RightButton") then
				clearShareQuestsData();
				updateShareQuestsButton();
			else
				createShareQuestsData();
				updateShareQuestsButton();
			end
		end)
		frame.button.tooltip = CreateFrame("Frame", "$parentTooltip", frame.button, "TooltipBorderedFrameTemplate");
		frame.button.tooltip:SetPoint("BOTTOM", frame.button, "TOP", 0, 2);
		frame.button.tooltip:SetFrameStrata("TOOLTIP");
		frame.button.tooltip:SetFrameLevel(9);
		frame.button.tooltip:SetClampedToScreen(true);
		frame.button.tooltip:SetBackdropColor(0, 0, 0);
		frame.button.tooltip.fs = frame.button.tooltip:CreateFontString("$parentTooltipFS", "ARTWORK");
		frame.button.tooltip.fs:SetPoint("CENTER", 0, 0);
		frame.button.tooltip.fs:SetFont("Fonts\\FRIZQT__.ttf", 10.5);
		frame.button.tooltip.fs:SetText("|cFF9CD6DE" .. L["startTooltip"]);
		frame.button.tooltip:SetWidth(frame.button.tooltip.fs:GetStringWidth() + 18);
		frame.button.tooltip:SetHeight(frame.button.tooltip.fs:GetStringHeight() + 12);
		frame.button:SetScript("OnEnter", function(self)
			if (NIH.db.global.showButtonTooltips) then
				frame.button.tooltip:Show();
			end
		end)
		frame.button:SetScript("OnLeave", function(self)
			frame.button.tooltip:Hide();
		end)
		frame.button.tooltip:Hide();
		
		frame.button2 = CreateFrame("Button", "$parentButton2", frame, "UIPanelButtonTemplate,InsecureActionButtonTemplate");
		frame.button2:SetAttribute("type", "macro");
		frame.button2:SetPoint("TOP", 0, -105);
		frame.button2:SetWidth(150);
		frame.button2:SetHeight(20);
		frame.button2:SetText(L["Share Quests"]);
		frame.button2:RegisterForClicks("LeftButtonDown", "RightButtonDown");
		frame.button2:HookScript("OnClick", function(self, arg)
			if (arg == "RightButton") then
				clearShareQuestsData();
				updateShareQuestsButton();
			else
				if (deleteQuestsCount ~= 0) then
					NIH:imitateGCD();
				end
			end
		end)
		frame.button2.cooldown = CreateFrame("Cooldown", "$parentCooldown", frame.button2, "CooldownFrameTemplate");
		frame.button2.cooldown:SetHideCountdownNumbers(true); --Hide cooldown number incase user has enabled it in options for hotbars.
		frame.button2.cooldown:SetSize(frame.button2:GetSize());
		frame.button2.cooldown:SetPoint("CENTER", frame.button2);
		frame.button2.cooldown:SetReverse(true);
		frame.button2.cooldown:SetDrawBling(false);
		frame.button2.tooltip = CreateFrame("Frame", "$parentTooltip", frame.button2, "TooltipBorderedFrameTemplate");
		--frame.button2.tooltip:SetPoint("BOTTOM", frame.button2, "TOP", 0, 2);
		frame.button2.tooltip:SetPoint("TOP", frame.button2, "BOTTOM", 0, -10);
		frame.button2.tooltip:SetFrameStrata("TOOLTIP");
		frame.button2.tooltip:SetFrameLevel(9);
		frame.button2.tooltip:SetClampedToScreen(true);
		frame.button2.tooltip:SetBackdropColor(0, 0, 0);
		frame.button2.tooltip.fs = frame.button2.tooltip:CreateFontString("$parentTooltipFS", "ARTWORK");
		frame.button2.tooltip.fs:SetPoint("CENTER", 0, 0);
		frame.button2.tooltip.fs:SetFont("Fonts\\FRIZQT__.ttf", 10.5);
		frame.button2.tooltip.fs:SetText("|cFF9CD6DE" .. L["shareQuestsTooltip"]);
		frame.button2.tooltip:SetWidth(frame.button2.tooltip.fs:GetStringWidth() + 18);
		frame.button2.tooltip:SetHeight(frame.button2.tooltip.fs:GetStringHeight() + 12);
		frame.button2:SetScript("OnEnter", function(self)
			if (NIH.db.global.showButtonTooltips) then
				frame.button2.tooltip:Show();
			end
		end)
		frame.button2:SetScript("OnLeave", function(self)
			frame.button2.tooltip:Hide();
		end)
		frame.button2.tooltip:Hide();
		
		frame.button3 = CreateFrame("Button", "$parentButton3", frame, "UIPanelButtonTemplate,InsecureActionButtonTemplate");
		frame.button3:SetAttribute("type", "macro");
		frame.button3:SetPoint("TOP", 0, -155);
		frame.button3:SetWidth(150);
		frame.button3:SetHeight(20);
		frame.button3:SetText(L["Open Envelopes"]);
		local macroText;
		local count = 0;
		for k, v in pairs(missionBriefs) do
			count = count + 1;
			if (count == 1) then
				macroText = "/run NIH_AO=true\n/use item:" .. k;
			else
				macroText = macroText .. "\n/use item:" .. k;
			end
		end
		macroText = macroText .. "\n/run NIH_OE()";
		frame.button3:SetAttribute("macrotext", macroText);
		--frame.button3:HookScript("OnClick", function(self, arg)
			--NIH:imitateGCD();
		--end)
		frame.button3.cooldown = CreateFrame("Cooldown", "$parentCooldown", frame.button3, "CooldownFrameTemplate");
		frame.button3.cooldown:SetHideCountdownNumbers(true);
		frame.button3.cooldown:SetSize(frame.button3:GetSize());
		frame.button3.cooldown:SetPoint("CENTER", frame.button3);
		frame.button3.cooldown:SetReverse(true);
		frame.button3.cooldown:SetDrawBling(false);
		frame.button3.tooltip = CreateFrame("Frame", "$parentTooltip", frame.button3, "TooltipBorderedFrameTemplate");
		frame.button3.tooltip:SetPoint("BOTTOM", frame.button3, "TOP", 0, 2);
		frame.button3.tooltip:SetFrameStrata("TOOLTIP");
		frame.button3.tooltip:SetFrameLevel(9);
		frame.button3.tooltip:SetClampedToScreen(true);
		frame.button3.tooltip:SetBackdropColor(0, 0, 0);
		frame.button3.tooltip.fs = frame.button3.tooltip:CreateFontString("$parentTooltipFS", "ARTWORK");
		frame.button3.tooltip.fs:SetPoint("CENTER", 0, 0);
		frame.button3.tooltip.fs:SetFont("Fonts\\FRIZQT__.ttf", 10.5);
		frame.button3.tooltip.fs:SetText("|cFF9CD6DE" .. L["openEnvelopesTooltip"]);
		frame.button3.tooltip:SetWidth(frame.button3.tooltip.fs:GetStringWidth() + 18);
		frame.button3.tooltip:SetHeight(frame.button3.tooltip.fs:GetStringHeight() + 12);
		frame.button3:SetScript("OnEnter", function(self)
			if (NIH.db.global.showButtonTooltips) then
				frame.button3.tooltip:Show();
			end
		end)
		frame.button3:SetScript("OnLeave", function(self)
			frame.button3.tooltip:Hide();
		end)
		frame.button3.tooltip:Hide();
		
		frame.button4 = CreateFrame("Button", "$parentButton4", frame, "UIPanelButtonTemplate");
		frame.button4:SetPoint("TOP", 0, -200);
		frame.button4:SetWidth(150);
		frame.button4:SetHeight(20);
		frame.button4:SetText(L["Delete Items"]);
		frame.button4:SetScript("OnClick", function(self, arg)
			deleteItem();
		end)
		frame.button4.tooltip = CreateFrame("Frame", "$parentTooltip", frame.button4, "TooltipBorderedFrameTemplate");
		frame.button4.tooltip:SetPoint("BOTTOM", frame.button4, "TOP", 0, 2);
		frame.button4.tooltip:SetFrameStrata("TOOLTIP");
		frame.button4.tooltip:SetFrameLevel(9);
		frame.button4.tooltip:SetClampedToScreen(true);
		frame.button4.tooltip:SetBackdropColor(0, 0, 0);
		frame.button4.tooltip.fs = frame.button4.tooltip:CreateFontString("$parentTooltipFS", "ARTWORK");
		frame.button4.tooltip.fs:SetPoint("CENTER", 0, 0);
		frame.button4.tooltip.fs:SetFont("Fonts\\FRIZQT__.ttf", 10.5);
		frame.button4.tooltip.fs:SetText("|cFF9CD6DE" .. L["deleteItemsTooltip"]);
		frame.button4.tooltip:SetWidth(frame.button4.tooltip.fs:GetStringWidth() + 18);
		frame.button4.tooltip:SetHeight(frame.button4.tooltip.fs:GetStringHeight() + 12);
		frame.button4:SetScript("OnEnter", function(self)
			if (NIH.db.global.showButtonTooltips) then
				frame.button4.tooltip:Show();
			end
		end)
		frame.button4:SetScript("OnLeave", function(self)
			frame.button4.tooltip:Hide();
		end)
		frame.button4.tooltip:Hide();
		
		frame.button5 = CreateFrame("Button", "$parentButton5", frame, "UIPanelButtonTemplate");
		frame.button5:SetPoint("TOP", 0, -220);
		frame.button5:SetWidth(150);
		frame.button5:SetHeight(20);
		frame.button5:SetText(L["Delete Quests"]);
		frame.button5:SetScript("OnClick", function(self, arg)
			deleteQuests();
		end)
		frame.button5.tooltip = CreateFrame("Frame", "$parentTooltip", frame.button5, "TooltipBorderedFrameTemplate");
		frame.button5.tooltip:SetPoint("BOTTOM", frame.button5, "TOP", 0, 2);
		frame.button5.tooltip:SetFrameStrata("TOOLTIP");
		frame.button5.tooltip:SetFrameLevel(9);
		frame.button5.tooltip:SetClampedToScreen(true);
		frame.button5.tooltip:SetBackdropColor(0, 0, 0);
		frame.button5.tooltip.fs = frame.button5.tooltip:CreateFontString("$parentTooltipFS", "ARTWORK");
		frame.button5.tooltip.fs:SetPoint("CENTER", 0, 0);
		frame.button5.tooltip.fs:SetFont("Fonts\\FRIZQT__.ttf", 10.5);
		frame.button5.tooltip.fs:SetText("|cFF9CD6DE" .. L["deleteQuestsTooltip"]);
		frame.button5.tooltip:SetWidth(frame.button5.tooltip.fs:GetStringWidth() + 18);
		frame.button5.tooltip:SetHeight(frame.button5.tooltip.fs:GetStringHeight() + 12);
		frame.button5:SetScript("OnEnter", function(self)
			if (NIH.db.global.showButtonTooltips) then
				frame.button5.tooltip:Show();
			end
		end)
		frame.button5:SetScript("OnLeave", function(self)
			frame.button5.tooltip:Hide();
		end)
		frame.button5.tooltip:Hide();
		
		frame.close = CreateFrame("Button", "$parentCloseButton", frame, "UIPanelCloseButton");
		frame.close:SetPoint("TOPRIGHT", 0, 0);
		frame.close:SetWidth(16);
		frame.close:SetHeight(16);
		frame.close:SetScript("OnClick", function(self, arg)
			frame.showHideMsg = true;
			overlayManuallyClosed = true;
			overlayManuallyOpened = false;
			frame:Hide();
		end)
		frame.close:GetNormalTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetHighlightTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetPushedTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetDisabledTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		
		frame.configButton = CreateFrame("Button", "$parentConfigButton", frame, "UIPanelButtonTemplate");
		frame.configButton:SetPoint("TOPRIGHT", -15, 0);
		frame.configButton:SetWidth(18);
		frame.configButton:SetHeight(15);
		frame.configButton:SetText("|TInterface\\Buttons\\UI-OptionsButton:10|t");
		frame.configButton:SetScript("OnClick", function(self, arg)
			NIH:openConfig();
		end)
	
		frame:Hide();
		
		frame:SetScript("OnHide", function(self, arg)
			if (frame.showHideMsg) then
				NIH:print("Nightmare incursion helper closed, type /nih to open it again.");
			end
			frame.showHideMsg = false;
		end)
		frame:SetScript("OnShow", function(self, arg)
			overlayManuallyClosed = false;
		end)
		
		frame.questLog = CreateFrame("Frame", "NIH_OverlayQL", frame);
		frame.questLog:SetFrameLevel(8);
		frame.questLog.background = CreateFrame("Frame", "NIH_OverlayQLBackground", frame.questLog, "BackdropTemplate");	
		frame.questLog.background:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8",
		});
		frame.questLog.background:SetBackdropColor(0, 0, 0);
		frame.questLog.background:SetAlpha(0.5);
		frame.questLog.background:SetFrameLevel(7);
		frame.questLog.background:SetAllPoints();
		frame.questLog:SetWidth(1);
		frame.questLog:SetHeight(1);
		frame.questLog:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 0);
		frame.questLog.counter = frame.questLog:CreateFontString("$parentCounter", "ARTWORK");
		frame.questLog.counter:SetPoint("TOPRIGHT", -3, -3);
		frame.questLog.counter:SetFont("Fonts\\FRIZQT__.ttf", 10.5);
		frame.questLog.fs = {};
		frame.questLog.fs2 = {};
		for i = 1, 18 do
			local fs = frame.questLog:CreateFontString("NIH_OverlayQLFS" .. i, "ARTWORK");
			fs:SetFont("Fonts\\FRIZQT__.ttf", 10, "OUTLINE");
			frame.questLog.fs[i] = fs;
			local fs2 = frame.questLog:CreateFontString("NIH_OverlayQLFS" .. i, "ARTWORK");
			fs2:SetFont("Fonts\\FRIZQT__.ttf", 10, "OUTLINE");
			frame.questLog.fs2[i] = fs2;
		end
		
		overlay = frame;
		updateShareQuestsButton();
	end
	--NIH:setOverlayState();
end

function NIH:setOverlayState()
	if (not overlay) then
		return;
	end
	if (NIH.db.global.showOverlay) then
		if (not overlay:IsShown()) then
			overlay:Show();
		end
	elseif (not overlayManuallyOpened) then
		if (overlay:IsShown()) then
			overlay:Hide();
		end
	end
	if (NIH.db.global.lockOverlay) then
		overlay:EnableMouse(false);
	else
		overlay:EnableMouse(true);
	end
	overlay:SetScale(NIH.db.global.overlayScale);
end

function NIH:loadOverlay()
	loadOverlay();
	updateDeleteButton();
end

NIH.optionDefaults = {
	global = {
		showOverlay = true,
		lockOverlay = false,
		automateQuests = true,
		showButtonTooltips = true,
		deleteQuestsGathering = true,
		deleteQuestsKill = false,
		deleteQuestsPickupItem = false,
		deleteQuestsAll = false,
	},
};

--Item used cooldown is always trigger for a short time even if item isn;t used.
local cooldownItemID, enableButtonsTimer, checkEnabled;
local gcdCheckElapsed = 0;
local function checkCooldownItemID()
	--[[if (cooldownItemID) then
        local _, duration = GetItemCooldown(cooldownItemID);
        if (duration == 0) then
        	C_Timer.After(0.1, function()	
            	NIH:enableButtons();
            end)
            overlay.button2.cooldown:SetScript("OnUpdate", nil);
		end
    else
    	print("error")
    end]]
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemID = GetContainerItemID(bag, slot);
            if (shareQuestItems[itemID]) then
            	local _, duration = GetItemCooldown(itemID);
		        if (duration == 0) then
		        	C_Timer.After(0.1, function()	
		            	NIH:enableButtons();
		            end)
		            overlay.button2:SetScript("OnUpdate", nil);
				end
				break;
            end
        end
    end
end

function NIH:enableButtons()
	if (shareQuestsLeftCount > 0) then
		overlay.button2:Enable();
	end
	--if (enableButtonsTimer) then
	--	enableButtonsTimer:Cancel();
	--end
	overlay.button2.cooldown:Clear();
	cooldownItemID = nil;
	--overlay.button2:SetScript("OnUpdate", nil);
end

--Disable certain buttons during GCD.
--Quest share items have a 1 second gcd if they succeed to share.
function NIH:disableButtons()
	overlay.button2:Disable();
	overlay.button2.cooldown:SetCooldown(GetTime(), 1);
	gcdCheckElapsed = GetTime();
	overlay.button2:SetScript("OnUpdate", function(self, button)
		if (GetTime() - gcdCheckElapsed > 0.05) then
			checkCooldownItemID();
		end
	end)
end

function NIH:imitateGCD()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemID = GetContainerItemID(bag, slot);
            if (shareQuestItems[itemID]) then
            	cooldownItemID = itemID;
				break;
            end
        end
    end
	NIH:disableButtons();
	--overlay.button2.cooldown:SetCooldown(GetTime(), 1.2);
	--enableButtonsTimer = C_Timer.NewTimer(1.2, function()
	--	NIH:enableButtons();
	--end)
end

--[[
local function updateGlobalCooldownState()
	--Why doesn't this work in classic?
	local _, duration = GetSpellCooldown(61304);
	if (duration and duration > 0) then
		print("gcd started");
	else
		print("gcd ended");
	end
end]]

local f = CreateFrame("Frame");
f:RegisterEvent("ADDON_LOADED");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("BAG_UPDATE_DELAYED");
f:RegisterEvent("QUEST_LOG_UPDATE");
f:RegisterEvent("ZONE_CHANGED_NEW_AREA");
f:RegisterEvent("LOOT_READY");
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "ADDON_LOADED") then
		local addon = ...;
		if (addon == addonName) then
			init();
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		NIH:loadOverlay();
		--checkLoadConditions();
		updateQuestLog();
		f:UnregisterEvent("PLAYER_ENTERING_WORLD");
	elseif (event == "LOOT_READY") then
		lootItem(...);
	elseif (event == "BAG_UPDATE_DELAYED") then
		updateOpenEnvelopesButton();
		updateDeleteButton();
	elseif (event == "QUEST_LOG_UPDATE") then
		updateQuestsTitle();
		loadQuestsToDelete();
		updateDeleteQuestsButton();
		updateQuestLog();
	end
end)


--Quest automation.
local f = CreateFrame("Frame");
f:RegisterEvent("GOSSIP_SHOW");
f:RegisterEvent("QUEST_DETAIL");
f:RegisterEvent("QUEST_PROGRESS");
f:RegisterEvent("QUEST_COMPLETE");
local lastAutoQuestMsg = 0;
f:SetScript('OnEvent', function(self, event, ...)
	--Check questIDs at the start seperately.
	if (event == "QUEST_DETAIL") then
		local questID = GetQuestID();
		if (questID and quests[questID]) then
			AcceptQuest();
		end
	end
	--Then check npcsID's for full quest automation.
	local npcGUID = UnitGUID("npc");
	local npcID;
	if (npcGUID) then
		_, _, _, _, _, npcID = strsplit("-", npcGUID);
	end
	if (not npcID) then
		return;
	end
	npcID = tonumber(npcID);
	if (questNpcs[npcID] and NIH.db.global.automateQuests) then
		local npcName = UnitName("npc");
		if (event == "GOSSIP_SHOW") then
			--Select available quests.
			local availableQuests = C_GossipInfo.GetAvailableQuests();
			if (next(availableQuests)) then
				local found;
				for index, questData in ipairs(availableQuests) do
					if (questData.questID) then
						if (not ignoredAutoQuests[questData.questID]) then
							if (GetTime() - lastAutoQuestMsg > 15) then
								NIH:print("Automating nightmare incursion quests at " .. npcName .. ".");
								lastAutoQuestMsg = GetTime();
							end
							return C_GossipInfo.SelectAvailableQuest(questData.questID);
						end
					end
				end
			end
			--Select completed quests.
			local activeQuests = C_GossipInfo.GetActiveQuests();
			for index, questData in ipairs(activeQuests) do
				if (questData.questID and questData.isComplete) then
					return C_GossipInfo.SelectActiveQuest(questData.questID);
				end
			end
		elseif (event == "QUEST_DETAIL") then
			--Accept quest being viewed.
			AcceptQuest();
		elseif (event == "QUEST_PROGRESS") then
			--Confirm quest is completable and move to final complete window.
			if (IsQuestCompletable()) then
				CompleteQuest();
			end
		elseif (event == "QUEST_COMPLETE") then
			--Hand in quest, no reward selection needed for the dailies.
			--But just incase they add rewards like rep tokens or something, check for reward acounts.
			--Still accept if only 1 reward.
			if (GetNumQuestChoices() < 2) then
				GetQuestReward(GetNumQuestChoices());
			end
		end
	end
	if (event == "GOSSIP_SHOW") then
		if (npcID and autoDialogueNpcs[npcID]) then
			NIH:selectGossipOption(1);
		end
	end
end)

function NIH:openConfig()
	--Opening the frame needs to be run twice to avoid a bug.
	InterfaceOptionsFrame_OpenToCategory("NightmareIncursionHelper");
	--Hack to fix the issue of interface options not opening to menus below the current scroll range.
	--This addon name starts with N and will always be closer to the middle so just scroll to the middle when opening.
	local min, max = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues();
	if (min < max) then
		InterfaceOptionsFrameAddOnsListScrollBar:SetValue(math.floor(max/2));
	end
	InterfaceOptionsFrame_OpenToCategory("NightmareIncursionHelper");
end

SLASH_NIHCMD1, SLASH_NIHCMD2 = '/nih', '/nightmareincursionhelper';
function SlashCmdList.NIHCMD(msg, editBox)
	if (msg) then
		msg = string.lower(msg);
	end
	if (msg == "options" or msg == "option" or msg == "config" or msg == "menu") then
		NIH:openConfig();
		return;
	end
	overlayManuallyOpened = true;
	overlay:Show();
end

function NIH:RGBToHex(r, g, b)
	r = tonumber(r);
	g = tonumber(g);
	b = tonumber(b);
	--Check if whole numbers.
	if (r == math.floor(r) and g == math.floor(g) and b == math.floor(b)
			and (r> 1 or g > 1 or b > 1)) then
		r = r <= 255 and r >= 0 and r or 0;
		g = g <= 255 and g >= 0 and g or 0;
		b = b <= 255 and b >= 0 and b or 0;
		return string.format("%02x%02x%02x", r, g, b);
	else
		return string.format("%02x%02x%02x", r*255, g*255, b*255);
	end
end

NIH.options = {
	name =  "",
	handler = NIH,
	type = 'group',
	args = {
		titleText = {
			type = "description",
			name = "|cFFFF6900Nightmare Incursion Helper (v" .. GetAddOnMetadata("NightmareIncursionHelper", "Version") .. ")",
			fontSize = "large",
			order = 1,
		},
		authorText = {
			type = "description",
			name = "|cFF9CD6DEby Novaspark-Arugal|r  |cFF00C800-|r  |cFFFFFF00For help or suggestions discord.gg/RTKMfTmkdj|r",
			fontSize = "medium",
			order = 2,
		},
		generalHeader = {
			type = "header",
			name = "|cFFFF6900" .. L["generalHeaderDesc"],
			order = 100,
		},
		autoLoadOverlay = {
			type = "toggle",
			name = L["autoLoadOverlayTitle"],
			desc = L["autoLoadOverlayDesc"],
			order = 101,
			set = function(info, value)
				NIH.db.global.autoLoadOverlay = value;
			end,
			get = function()
				return NIH.db.global.autoLoadOverlay;
			end,
		},
		lockOverlay = {
			type = "toggle",
			name = L["lockOverlayTitle"],
			desc = L["lockOverlayDesc"],
			order = 102,
			set = function(info, value)
				NIH.db.global.lockOverlay = value;
				NIH:setOverlayState();
			end,
			get = function()
				return NIH.db.global.lockOverlay;
			end,
		},
		automateQuests = {
			type = "toggle",
			name = L["automateQuestsTitle"],
			desc = L["automateQuestsDesc"],
			order = 104,
			set = function(info, value)
				NIH.db.global.automateQuests = value;
			end,
			get = function()
				return NIH.db.global.automateQuests;
			end,
		},
		showButtonTooltips = {
			type = "toggle",
			name = L["showButtonTooltipsTitle"],
			desc = L["showButtonTooltipsDesc"],
			order = 105,
			set = function(info, value)
				NIH.db.global.showButtonTooltips = value;
			end,
			get = function()
				return NIH.db.global.showButtonTooltips;
			end,
		},
		overlayScale = {
			type = "range",
			name = L["overlayScaleTitle"],
			desc = L["overlayScaleDesc"],
			order = 106,
			set = function(info, value)
				NIH.db.global.overlayScale = value;
				NIH:setOverlayState();
			end,
			get = function()
				return NIH.db.global.overlayScale;
			end,
			min = 0.3,
			max = 2,
			softMin = 0.3,
			softMax = 2,
			step = 0.1,
		},
		deleteItemsHeader = {
			type = "header",
			name = "|cFFFF6900" .. L["deleteItemsHeaderDesc"],
			order = 200,
		},
		deleteItemsMissionBrief = {
			type = "toggle",
			name = L["deleteItemsMissionBriefTitle"],
			desc = L["deleteItemsMissionBriefDesc"],
			order = 201,
			set = function(info, value)
				NIH.db.global.deleteItemsMissionBrief = value;
				updateDeleteButton();
			end,
			get = function()
				return NIH.db.global.deleteItemsMissionBrief;
			end,
		},
		deleteItemsQuestStart = {
			type = "toggle",
			name = L["deleteItemsQuestStartTitle"],
			desc = L["deleteItemsQuestStartDesc"],
			order = 202,
			set = function(info, value)
				NIH.db.global.deleteItemsQuestStart = value;
				updateDeleteButton();
			end,
			get = function()
				return NIH.db.global.deleteItemsQuestStart;
			end,
		},
		deleteItemsDeputize = {
			type = "toggle",
			name = L["deleteItemsDeputizeTitle"],
			desc = L["deleteItemsDeputizeDesc"],
			order = 203,
			set = function(info, value)
				NIH.db.global.deleteItemsDeputize = value;
				updateDeleteButton();
			end,
			get = function()
				return NIH.db.global.deleteItemsDeputize;
			end,
		},
		
		deleteQuestsHeader = {
			type = "header",
			name = "|cFFFF6900" .. L["deleteQuestsHeaderDesc"],
			order = 300,
		},
		deleteQuestsGathering = {
			type = "toggle",
			name = L["deleteQuestsGatheringTitle"],
			desc = L["deleteQuestsGatheringDesc"],
			order = 301,
			set = function(info, value)
				NIH.db.global.deleteQuestsGathering = value;
				loadQuestsToDelete();
				updateDeleteQuestsButton();
			end,
			get = function()
				return NIH.db.global.deleteQuestsGathering;
			end,
		},
		deleteQuestsKill = {
			type = "toggle",
			name = L["deleteQuestsKillTitle"],
			desc = L["deleteQuestsKillDesc"],
			order = 302,
			set = function(info, value)
				NIH.db.global.deleteQuestsKill = value;
				loadQuestsToDelete();
				updateDeleteQuestsButton();
			end,
			get = function()
				return NIH.db.global.deleteQuestsKill;
			end,
		},
		deleteQuestsPickupItem = {
			type = "toggle",
			name = L["deleteQuestsPickupItemTitle"],
			desc = L["deleteQuestsPickupItemDesc"],
			order = 303,
			set = function(info, value)
				NIH.db.global.deleteQuestsPickupItem = value;
				loadQuestsToDelete();
				updateDeleteQuestsButton();
			end,
			get = function()
				return NIH.db.global.deleteQuestsPickupItem;
			end,
		},
		deleteQuestsEscort = {
			type = "toggle",
			name = L["deleteQuestsEscortTitle"],
			desc = L["deleteQuestsEscortDesc"],
			order = 304,
			set = function(info, value)
				NIH.db.global.deleteQuestsEscort = value;
				loadQuestsToDelete();
				updateDeleteQuestsButton();
			end,
			get = function()
				return NIH.db.global.deleteQuestsEscort;
			end,
		},
		deleteQuestsAll = {
			type = "toggle",
			name = L["deleteQuestsAllTitle"],
			desc = L["deleteQuestsAllDesc"],
			order = 305,
			set = function(info, value)
				NIH.db.global.deleteQuestsAll = value;
				loadQuestsToDelete();
				updateDeleteQuestsButton();
			end,
			get = function()
				return NIH.db.global.deleteQuestsAll;
			end,
		},
		
		questLogHeader = {
			type = "header",
			name = "|cFFFF6900" .. L["questLogHeaderDesc"],
			order = 400,
		},
		questLogGathering = {
			type = "toggle",
			name = L["questLogGatheringTitle"],
			desc = L["questLogGatheringDesc"],
			order = 401,
			set = function(info, value)
				NIH.db.global.questLogGathering = value;
				updateQuestLog();
			end,
			get = function()
				return NIH.db.global.questLogGathering;
			end,
		},
		questLogKill = {
			type = "toggle",
			name = L["questLogKillTitle"],
			desc = L["questLogKillDesc"],
			order = 402,
			set = function(info, value)
				NIH.db.global.questLogKill = value;
				updateQuestLog();
			end,
			get = function()
				return NIH.db.global.questLogKill;
			end,
		},
		questLogPickupItem = {
			type = "toggle",
			name = L["questLogPickupItemTitle"],
			desc = L["questLogPickupItemDesc"],
			order = 403,
			set = function(info, value)
				NIH.db.global.questLogPickupItem = value;
				updateQuestLog();
			end,
			get = function()
				return NIH.db.global.questLogPickupItem;
			end,
		},
		questLogEscort = {
			type = "toggle",
			name = L["questLogEscortTitle"],
			desc = L["questLogEscortDesc"],
			order = 404,
			set = function(info, value)
				NIH.db.global.questLogEscort = value;
				updateQuestLog();
			end,
			get = function()
				return NIH.db.global.questLogEscort;
			end,
		},
			
		helpHeader = {
			type = "header",
			name = "|cFF00FF00" .. L["helpHeaderDesc"],
			order = 900,
		},
		helpText = {
			type = "description",
			name = "|cFF9CD6DE\n" .. L["helpTextDesc"],
			fontSize = "medium",
			order = 901,
		},
	},
};

NIH.optionDefaults = {
	global = {
		showOverlay = true,
		autoLoadOverlay = true,
		lockOverlay = false,
		automateQuests = true,
		showButtonTooltips = true,
		overlayScale = 1,
		showQuestLog = true,
		deleteItemsMissionBrief = true,
		deleteItemsQuestStart = true,
		deleteItemsDeputize = true,
		deleteQuestsGathering = true,
		deleteQuestsKill = false,
		deleteQuestsPickupItem = false,
		deleteQuestsEscort = false,
		deleteQuestsAll = false,
		questLogGathering = false,
		questLogKill = false,
		questLogPickupItem = false,
		questLogEscort = false,
	},
};

function NIH:pairsByKeys(t, f)
	local a = {};
	for n in pairs(t) do
		tinsert(a, n);
	end
	table.sort(a, f);
	local i = 0;
	local iter = function()
		i = i + 1;
		if (a[i] == nil) then
			return nil;
		else
			return a[i], t[a[i]];
		end
	end
	return iter;
end

function NIH:selectGossipOption(id)
    --A fix so the addon "Immersion" doesn't clash with gossip automation.
    --SelectGossipOption seems to require the Blizzard dialog open.
    --C_GossipInfo.SelectOptionByIndex seems to remember the last opened and works after it's closed?
    if (ImmersionAPI and C_GossipInfo and C_GossipInfo.SelectOptionByIndex) then
        --C_GossipInfo.SelectOptionByIndex index starts at 0 so we need to minus 1.
        C_GossipInfo.SelectOptionByIndex(id - 1)
    else
        SelectGossipOption(id);
    end
end

local doScan;
local function disableScan()
	--NIH:debug("Stopping NIH scan.");
	doScan = false;
	if (NIH.db.global.autoLoadOverlay) then
		overlay:Hide();
	end
end

--Emerald dream spellIDs.
--444762 Feralas.
--444758 Duskwood.
--444759 Ashenvale.
--444760 Hinterlands.
local function scanTicker()
	if (not doScan) then
		return;
	end
	local x, y, zone = NIH.dragonLib:GetPlayerZonePosition();
	if (incursionZonesLarge[zone]) then
		local data;
		if (GetPlayerAuraBySpellID(444758) or GetPlayerAuraBySpellID(444759) or GetPlayerAuraBySpellID(444760)
				or GetPlayerAuraBySpellID(444762)) then
			--Inside the incursion, keep up the overlay in the entire area.
			data = incursionZonesLarge[zone];
		else
			data = incursionZones[zone];
		end
		--If our coords are outside the square.
		--print(x < data.left, x > data.right, y > data.bottom, y < data.top, overlayManuallyOpened, overlayManuallyClosed)
		if (x < data.left or x > data.right or y > data.bottom or y < data.top) then
			if (not overlayManuallyOpened) then
				overlay:Hide();
				overlayManuallyClosed = false;
				inbounds = false;
			end
		elseif (NIH.db.global.autoLoadOverlay) then
			if (not overlayManuallyClosed and NIH.db.global.autoLoadOverlay) then
				inbounds = true;
				NIH:setOverlayState();
			end
		end
	else
		inbounds = false;
		overlayManuallyClosed = false;
		disableScan();
	end
	C_Timer.After(2, function()
		scanTicker();
	end)
end

local function enableScan()
	--NIH:debug("Starting NIH scan.");
	doScan = true;
	scanTicker();
end

local scanFrame = CreateFrame("Frame");
scanFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
scanFrame:RegisterEvent("AREA_POIS_UPDATED");
scanFrame:SetScript("OnEvent", function(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD" or event == "AREA_POIS_UPDATED") then
		--Must use GetServerTime() and not GetTime() for logon or its unreliable.
		if (UnitOnTaxi("player")) then
			--Each incursion area is far from flight paths so AREA_POIS_UPDATED will start it after landing.
			return;	
		end
		local _, _, zone = NIH.dragonLib:GetPlayerZonePosition();
		if (zone) then
			if (incursionZonesLarge[zone] and not doScan) then
				enableScan();
			elseif (doScan and not incursionZonesLarge[zone]) then
				disableScan();
			end
		end
	end
end)

function NIH:debug(...)
	local data = ...;
	if (data and NIH.isDebug) then
		if (type(data) == "table") then
			UIParentLoadAddOn("Blizzard_DebugTools");
			--DevTools_Dump(data);
    		DisplayTableInspectorWindow(data);
    	else
			print("NIHDebug:", ...);
		end
	end
end