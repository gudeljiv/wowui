local L = LibStub("AceLocale-3.0"):NewLocale("NightmareIncursionHelper", "enUS", true, true);

--Make sure \n newline char is used when translating this or the tooltip will be one line and super wide.
L["startTooltip"] = "This loads your group members\nand your quest items from bags.\nClick this before you start using \"Share Quests\" button.\n|cFFFFFF00Right click to clear data.";
L["shareQuestsTooltip"] = "Click this to start clicking your quest items in bags.\nThis cycles through targeting your group members\nand using all quest items on them.";
L["openEnvelopesTooltip"] = "Open envelopes in your bags\nand auto start your quests.\nAlso deletes duplicate quests.";
L["deleteItemsTooltip"] = "Deletes all incursion related items from bags.\n(Does not delete quest items you looted in the incursion don't worrie).\nYou need to spam click this once for every item.";
L["deleteQuestsTooltip"] = "Deletes quests you have configured to delete in options.";


L["generalHeaderDesc"] = "General Options";
L["deleteItemsHeaderDesc"] = "\"Delete Items\" Button Options";
L["deleteQuestsHeaderDesc"] = "\"Delete Quests\" Button Options";
L["questLogHeaderDesc"] = "Quest Tracker Display (Ashenvale only, speed running helper)";

L["autoLoadOverlayTitle"] = "Auto Load Overlay";
L["autoLoadOverlayDesc"] = "This will auto load the addon overlay when you are close to a nightmare incursion.";

L["lockOverlayTitle"] = "Lock Overlay";
L["lockOverlayDesc"] = "Lock the overlay so it can't be moved.";

L["automateQuestsTitle"] = "Automate Quests";
L["automateQuestsDesc"] = "Automate quests when you talk to the quest giver outside the nightmare incursion.";

L["showButtonTooltipsTitle"] = "Show Tooltips";
L["showButtonTooltipsDesc"] = "Show tooltips when you mouseover each button.";

L["overlayScaleTitle"] = "Overlay Size";
L["overlayScaleDesc"] = "Change the size of the adodn overlay.";

L["deleteItemsMissionBriefTitle"] = "Mission Brief";
L["deleteItemsMissionBriefDesc"] = "Delete missions brief envelopes when you click the delete items button.";

L["deleteItemsQuestStartTitle"] = "Quest Start";
L["deleteItemsQuestStartDesc"] = "Delete quest start envelopes when you click the delete items button.";

L["deleteItemsDeputizeTitle"] = "Deputization";
L["deleteItemsDeputizeDesc"] = "Delete deputize items when you click the delete items button.";

L["deleteQuestsGatheringTitle"] = "Gathering Quests";
L["deleteQuestsGatheringDesc"] = "Delete gathering quests when you click the delete quests button.";

L["deleteQuestsKillTitle"] = "Kill Quests";
L["deleteQuestsKillDesc"] = "Delete kill quests when you click the delete quests button.";

L["deleteQuestsPickupItemTitle"] = "Pickup Item Quests";
L["deleteQuestsPickupItemDesc"] = "Delete pickup item quests when you click the delete quests button.";

L["deleteQuestsEscortTitle"] = "Escort Quests";
L["deleteQuestsEscortDesc"] = "Delete escort quests when you click the delete quests button.";

L["deleteQuestsAllTitle"] = "All Quest";
L["deleteQuestsAllDesc"] = "Delete all quests when you click the delete quests button, overrides other quest delete settings.";

L["questLogGatheringTitle"] = "Gathering Quests";
L["questLogGatheringDesc"] = "Show your gathering quests beside the overlay (Helpful for speed running strats).";

L["questLogKillTitle"] = "Kill Quests";
L["questLogKillDesc"] = "Show your kill quests beside the overlay (Helpful for speed running strats).";

L["questLogPickupItemTitle"] = "Pickup Item Quests";
L["questLogPickupItemDesc"] = "Show your pickup item quests beside the overlay (Helpful for speed running strats).";

L["questLogEscortTitle"] = "Escort Quests";
L["questLogEscortDesc"] = "Show your escort quests beside the overlay (Helpful for speed running strats).";

L["helpHeaderDesc"] = "How to use this addon"
L["helpTextDesc"] = "1) Once you have some quests to share with your group click the \"Start (Load Quests)\" button. This will load all your group members and your quest items into the addon."
	.. "\n\n2) Spam the \"Share Quests\" button and it will cycle through your group members and quests one by one. |cFFFFFF00Make sure your whole group is stacked close in range before this.|r"
	.."\n\n3) After you've shared all quests and made sure all group members have them you can spam the \"Delete Items\" button to delete unused items (this makes it easier when opening the next round of envelopes)."
	.."\n\n4) Go in and complete your quests."
	.."\n\n5) Go back out to the NPC and hand in all your quests, then start clicking the \"Open Envelopes\" button. If you get a duplicate quest just click same button again to delete it."
	.."\n\n6) After you've oepend all your envelopes for your new quest items, open bags and right click the quest start envelopes, get your group to stack back up and start again from the start step 1 by sharing your quests."
	.."\n\n\nYou can also change setings to delete certain quest types and use the \"Delete Quests\" button if you like (gathering quests are enabled by default)."
	.. "\n\n\n|cFFFFFF00Tip: You can right click the Start button to clear the loaded data and text.|r";