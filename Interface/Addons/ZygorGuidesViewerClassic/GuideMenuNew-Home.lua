local ZGV = ZygorGuidesViewer
if not ZGV then return end

local GuideMenu = ZGV.GuideMenu

GuideMenu.HomeVersion = 1
GuideMenu.Home={
	{"banner", image=ZGV.DIR.."\\Skins\\banner"},

	{"title", text=[[Featured Content]]},

	{"section", text=[[EVENTS]]},
	{"item", text=[[Added |cfffe6100Love is in the Air Quests|r.]], guide="EVENTS\\Love is in the Air\\Love is in the Air Quests"},
	{"item", text=[[Added |cfffe6100Love is in the Air Gift Giving quest|r.]], guide="EVENTS\\Love is in the Air\\Gift Giving"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Sayge's Fortunes (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Sayge's Fortunes (Mulgore)"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Chronos Turn-Ins (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Chronos Turn-Ins (Mulgore)"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Kerri Hicks Turn-Ins (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Kerri Hicks Turn-Ins (Mulgore)"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Rinling Turn-Ins (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Rinling Turn-Ins (Mulgore)"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Yebb Neblegear Turn-Ins (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Yebb Neblegear Turn-Ins (Mulgore)"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Spawn of Jubjub (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Spawn of Jubjub (Mulgore)"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Wood Frog (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Wood Frog (Mulgore)"},
	{"item", text=[[Added |cfffe6100Darkmoon Faire Tree Frog (Mulgore)|r.]], guide="EVENTS\\Darkmoon Faire\\Tree Frog (Mulgore)"},

	{"section", text=[[DUNGEONS]]},
	{"item", text=[[Added |cfffe6100Ragefire Chasm (13-18)|r.]], guide="DUNGEONS\\Ragefire Chasm (13-18)",faction="H"},
	{"item", text=[[Added |cfffe6100Ragefire Chasm Quests|r.]], guide="DUNGEONS\\Ragefire Chasm Quests",faction="H"},
	{"item", text=[[Added |cfffe6100Wailing Caverns (15-25)|r.]], guide="DUNGEONS\\Wailing Caverns (15-25)"},
	{"item", text=[[Added |cfffe6100Wailing Caverns Quests|r.]], guide="DUNGEONS\\Wailing Caverns Quests"},
	{"item", text=[[Added |cfffe6100Deadmines (17-26)|r.]], guide="DUNGEONS\\Deadmines (17-26)"},
	{"item", text=[[Added |cfffe6100The Deadmines Quests|r.]], guide="DUNGEONS\\The Deadmines Quests",faction="A"},
	{"item", text=[[Added |cfffe6100Shadowfang Keep (22-30)|r.]], guide="DUNGEONS\\Shadowfang Keep (22-30)"},
	{"item", text=[[Added |cfffe6100Shadowfang Keep Quests|r.]], guide="DUNGEONS\\Scarlet Monastery Cathedral Quests"},
	{"item", text=[[Added |cfffe6100The Stockades (22-30)|r.]], guide="DUNGEONS\\The Stockades (22-30)",faction="A"},
	{"item", text=[[Added |cfffe6100The Stockade Quests|r.]], guide="DUNGEONS\\The Stockade Quests",faction="A"},
	{"item", text=[[Added |cfffe6100Blackfathom Deeps (24-32)|r.]], guide="DUNGEONS\\Blackfathom Deeps (24-32)",faction="H"},
	{"item", text=[[Added |cfffe6100Blackfathom Deeps Quests|r.]], guide="DUNGEONS\\Blackfathom Deeps Quests"},
	{"item", text=[[Added |cfffe6100Gnomeregan (29-38)|r.]], guide="DUNGEONS\\Gnomeregan (29-38)"},
	{"item", text=[[Added |cfffe6100Gnomeregan Quests|r.]], guide="DUNGEONS\\Gnomeregan Quests"},
	{"item", text=[[Added |cfffe6100Razorfen Kraul (30-40)|r.]], guide="DUNGEONS\\Razorfen Kraul (30-40)"},
	{"item", text=[[Added |cfffe6100Razorfen Kraul Quests|r.]], guide="DUNGEONS\\Razorfen Kraul Quests"},
	{"item", text=[[Added |cfffe6100Scarlet Monastery (Graveyard) (29-35)|r.]], guide="DUNGEONS\\Scarlet Monastery (Graveyard) (29-35)"},
	{"item", text=[[Added |cfffe6100Razorfen Kraul Quests|r.]], guide="DUNGEONS\\Scarlet Monastery Graveyard Quests)", faction="H"},
	{"item", text=[[Added |cfffe6100Scarlet Monastery (Library) (31-37)|r.]], guide="DUNGEONS\\Scarlet Monastery (Library) (31-37)"},
	{"item", text=[[Added |cfffe6100Scarlet Monastery Library Quests|r.]], guide="DUNGEONS\\Scarlet Monastery Library Quests"},
	{"item", text=[[Added |cfffe6100Scarlet Monastery (Armory) (35-40)|r.]], guide="DUNGEONS\\Scarlet Monastery (Armory) (35-40)"},
	{"item", text=[[Added |cfffe6100Razorfen Kraul Quests|r.]], guide="DUNGEONS\\Scarlet Monastery Armory Quests)"},
	{"item", text=[[Added |cfffe6100Scarlet Monastery (Cathedral) (36-42)|r.]], guide="DUNGEONS\\Scarlet Monastery (Cathedral) (36-42)"},
	{"item", text=[[Added |cfffe6100Scarlet Monastery Cathedral Quests|r.]], guide="DUNGEONS\\Scarlet Monastery Cathedral Quests"},
	{"item", text=[[Added |cfffe6100Razorfen Downs (37-43)|r.]], guide="DUNGEONS\\Razorfen Downs (37-43)",faction="H"},
	{"item", text=[[Added |cfffe6100Razorfen Downs Quests|r.]], guide="DUNGEONS\\Razorfen Downs Quests"},
	{"item", text=[[Added |cfffe6100Uldaman (42-52)|r.]], guide="DUNGEONS\\Uldaman (42-52)"},
	{"item", text=[[Added |cfffe6100Uldaman Quests|r.]], guide="DUNGEONS\\Uldaman Quests"},
	{"item", text=[[Added |cfffe6100Zul'Farrak (44-49)|r.]], guide="DUNGEONS\\Zul'Farrak (44-49)"},
	{"item", text=[[Added |cfffe6100Zul'Farrak Quests|r.]], guide="DUNGEONS\\Zul'Farrak Quests"},
	{"item", text=[[Added |cfffe6100Maraudon (Wicked Grotto - Purple) (45-53)|r.]], guide="DUNGEONS\\Maraudon (Wicked Grotto - Purple) (45-53)"},
	{"item", text=[[Added |cfffe6100Maraudon (Foulspore Cavern - Orange) (45-53)|r.]], guide="DUNGEONS\\Maraudon (Foulspore Cavern - Orange) (45-53)"},
	{"item", text=[[Added |cfffe6100Maraudon (Earth Song Falls - Inner) (48-57)|r.]], guide="DUNGEONS\\Maraudon (Earth Song Falls - Inner) (48-57)"},
	{"item", text=[[Added |cfffe6100Maraudon Quests|r.]], guide="DUNGEONS\\Maraudon Quests"},
	{"item", text=[[Added |cfffe6100The Temple of Atal'Hakkar (50-60)|r.]], guide="DUNGEONS\\The Temple of Atal'Hakkar (50-60)"},
	{"item", text=[[Added |cfffe6100The Temple of Atal'Hakkar Quests|r.]], guide="DUNGEONS\\Temple of Atal'Hakkar Quests"},
	{"item", text=[[Added |cfffe6100Blackrock Depths (52-60)|r.]], guide="DUNGEONS\\Blackrock Depths (52-60)"},
	{"item", text=[[Added |cfffe6100Blackrock Depths Quests|r.]], guide="DUNGEONS\\Blackrock Depths Quests"},
	{"item", text=[[Added |cfffe6100Scholomance (58-60)|r.]], guide="DUNGEONS\\Scholomance (58-60)"},
	{"item", text=[[Added |cfffe6100Stratholme - Live (58-60)|r.]], guide="DUNGEONS\\Stratholme - Live (58-60)"},
	{"item", text=[[Added |cfffe6100Stratholme - Undead (58-60)|r.]], guide="DUNGEONS\\Stratholme - Undead (58-60)"},
	{"item", text=[[Added |cfffe6100Dire Maul East (58-60)|r.]], guide="DUNGEONS\\Dire Maul East (58-60)"},
	{"item", text=[[Added |cfffe6100Dire Maul North (58-60)|r.]], guide="DUNGEONS\\Dire Maul North (58-60)"},
	{"item", text=[[Added |cfffe6100Dire Maul West (58-60)|r.]], guide="DUNGEONS\\Dire Maul West (58-60)"},
	{"item", text=[[Added |cfffe6100Dire Maul North Tribute (58-60)|r.]], guide="DUNGEONS\\Dire Maul North Tribute (58-60)"},
	{"item", text=[[Added |cfffe6100Lower Blackrock Spire (55-60)|r.]], guide="DUNGEONS\\Lower Blackrock Spire (55-60)"},
	{"item", text=[[Added |cfffe6100Upper Blackrock Spire (55-60)|r.]], guide="DUNGEONS\\Upper Blackrock Spire (55-60)"},

	{"item", text=[[Added |cfffe6100Molten Core Attunement|r.]], guide="DUNGEONS\\Raid Attunements\\Molten Core Attunement"},
	{"item", text=[[Added |cfffe6100Onyxia's Lair Attunement|r.]], guide="DUNGEONS\\Raid Attunements\\Onyxia's Lair Attunement"},
	{"item", text=[[Added |cfffe6100Blackwing Lair Attunement|r.]], guide="DUNGEONS\\Raid Attunements\\Blackwing Lair Attunement"},


}


-- faction="Alliance" {"separator"},