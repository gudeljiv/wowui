

skills = dict()

skills["healing"] = [
    {"name": "healthstone", "type": "GetSpellTexture", "id": 5720,  "key": "4", "modifier": "alt"},
    {"name": "healing potion", "type": "GetSpellTexture", "id": 28491, "key": "5", "modifier": "alt"},
    {"name": "fel blossom", "type": "GetSpellTexture", "id": 28527, "key": "6", "modifier": "alt"},
    {"name": "lifeblood", "type": "GetSpellTexture", "id": 55428, "key": "7", "modifier": "alt"},
]

skills["offgcd"] = dict()
skills["offgcd"]["warrior"] = [
    {"name": "heroic strike", "type": "GetSpellTexture", "id": 78, "key": "2"},
    {"name": "cleave", "type": "GetSpellTexture", "id": 845, "key": "3"},
    {"name": "shield wall", "type": "GetSpellTexture", "id": 871, "key": "t"},
    {"name": "spell reflection", "type": "GetSpellTexture", "id": 23920, "key": "v"},
    {"name": "shield block", "type": "GetSpellTexture", "id": 2565, "key": "f4", "modifier": "ctrl"},
    {"name": "last stand", "type": "GetSpellTexture", "id": 12975, "key": "t", "modifier": "shift"},
    {"name": "battlemaster's resolve", "type": "GetItemIcon", "id": 41589, "key": "1", "modifier": "alt"},
]

skills["offgcd"]["druid"] = [
    {"name": "maul", "type": "GetSpellTexture", "id": 6807, "key": "1"},
    {"name": "nature's grasp", "type": "GetSpellTexture", "id": 16689, "key": "f", "modifier": "alt"},
]

skills["offgcd"]["death knight"] = [
    {"name": "rune strike", "type": "GetSpellTexture", "id": 56815, "key": "f3", "modifier": "ctrl"},
    {"name": "rune tap", "type": "GetSpellTexture", "id": 48982, "key": "h"},
    {"name": "blood tap", "type": "GetSpellTexture", "id": 45529, "key": "f4", "modifier": "ctrl"},
    {"name": "anti-magic shell", "type": "GetSpellTexture", "id": 48707, "key": "g"},
    {"name": "battlemaster's resolve", "type": "GetItemIcon", "id": 41589, "key": "r", "modifier": "alt"},
]

skills["offgcd"]["hunter"] = [
    {"name": "misdirection", "type": "GetSpellTexture", "id": 34477, "key": "2", "modifier": "alt"},
]


skills["warrior"] = [
    {"name": "battle shout", "type": "GetSpellTexture", "id": 2048, "key": "f4"},
    {"name": "commanding shout", "type": "GetSpellTexture", "id": 469, "key": "f6"},
    {"name": "demoralizing shout", "type": "GetSpellTexture", "id": 1160, "key": "f5"},
    {"name": "sunder armor", "type": "GetSpellTexture", "id": 7386, "key": "k"},
    {"name": "bloodthirst", "type": "GetSpellTexture", "id": 23881, "key": "f1", "modifier": "ctrl"},
    {"name": "mortal strike", "type": "GetSpellTexture", "id": 12294, "key": "f1", "modifier": "ctrl"},
    {"name": "berserker rage", "type": "GetSpellTexture", "id": 18499, "key": "f4", "modifier": "ctrl"},
    {"name": "rend", "type": "GetSpellTexture", "id": 772, "key": "d", "modifier": "shift"},
    {"name": "overpower", "type": "GetSpellTexture", "id": 7384, "key": "6"},
    {"name": "revenge", "type": "GetSpellTexture", "id": 6572, "key": "f3", "modifier": "ctrl"},
    {"name": "execute", "type": "GetSpellTexture", "id": 5308, "key": "f"},
    {"name": "whirlwind", "type": "GetSpellTexture", "id": 1680, "key": "6"},
    {"name": "sweeping strikes", "type": "GetSpellTexture", "id": 12328, "key": "r", "modifier": "alt"},
    {"name": "victory rush", "type": "GetSpellTexture", "id": 34428, "key": "e", "modifier": "shift"},
    {"name": "disarm", "type": "GetSpellTexture", "id": 676, "key": "e", "modifier": "shift"},
    {"name": "thunder clap", "type": "GetSpellTexture", "id": 6343, "key": "e"},
    {"name": "shield slam", "type": "GetSpellTexture", "id": 23922, "key": "4"},
    {"name": "devastate", "type": "GetSpellTexture", "id": 20243, "key": "f2", "modifier": "ctrl"},
    {"name": "vigilance", "type": "GetSpellTexture", "id": 50720, "key": "d", "modifier": "shift"},
    {"name": "concussion blow", "type": "GetSpellTexture", "id": 12809, "key": "8"},
    {"name": "hamstring", "type": "GetSpellTexture", "id": 1715, "key": "1"}
]


skills["warlock"] = [
    {"name": "immolate", "type": "GetSpellTexture", "id": 348, "key": "h"},
    {"name": "corruption", "type": "GetSpellTexture", "id": 172, "key": "v"},
    {"name": "curse of agony", "type": "GetSpellTexture", "id": 980, "key": "g"},
    {"name": "shadow bolt", "type": "GetSpellTexture", "id": 686, "key": "f11"}
]


skills["hunter"] = [
    {"name": "concussive shot", "type": "GetSpellTexture", "id": 5116, "key": "1"},
    {"name": "steady shot", "type": "GetSpellTexture", "id": 34120, "key": "2"},
    {"name": "kill command", "type": "GetSpellTexture", "id": 34026, "key": "4"},
    {"name": "serpent sting", "type": "GetSpellTexture", "id": 1978, "key": "f3", "modifier": "ctrl"},
    {"name": "multi-shot", "type": "GetSpellTexture", "id": 2643, "key": "f1", "modifier": "ctrl"},
    {"name": "arcane shot", "type": "GetSpellTexture", "id": 3044, "key": "f2", "modifier": "ctrl"},
    {"name": "aspect of the hawk", "type": "GetSpellTexture", "id": 13165, "key": "f1"},
    {"name": "aspect of the viper", "type": "GetSpellTexture", "id": 34074, "key": "f5"},
    {"name": "chimera shot", "type": "GetSpellTexture", "id": 53209, "key": "3"},
    {"name": "aimed shot", "type": "GetSpellTexture", "id": 19434, "key": "6"},
    {"name": "deterrence", "type": "GetSpellTexture", "id": 19263, "key": "t", "modifier": "shift"},
    {"name": "trueshot aura", "type": "GetSpellTexture", "id": 19506, "key": "1", "modifier": "alt"},
    {"name": "wing clip", "type": "GetSpellTexture", "id": 2974, "key": "1", "modifier": "alt"},
    {"name": "hunter's mark", "type": "GetSpellTexture", "id": 1130, "key": "3", "modifier": "alt"},
    {"name": "mend pet", "type": "GetSpellTexture", "id": 136, "key": "v"},
    {"name": "cower pet", "type": "GetSpellTexture", "id": 1742, "key": "4", "modifier": "ctrl"},
    {"name": "last stand pet", "type": "GetSpellTexture", "id": 53478, "key": "5", "modifier": "ctrl"},
    {"name": "kill shot", "type": "GetSpellTexture", "id": 53351, "key": "e"},
]

skills["druid"] = [
    {"name": "swipe", "type": "GetSpellTexture", "id": 50256, "key": "2"},
    {"name": "demoralizing roar", "type": "GetSpellTexture", "id": 99, "key": "3", "modifier": "alt"},
    {"name": "claw", "type": "GetSpellTexture", "id": 1082, "key": "1"},
    {"name": "shred", "type": "GetSpellTexture", "id": 5221, "key": "2"},
    {"name": "rip", "type": "GetSpellTexture", "id": 1079, "key": "5"},
    {"name": "rake", "type": "GetSpellTexture", "id": 1822, "key": "3"},
    {"name": "faerie fire", "type": "GetSpellTexture", "id": 770, "key": "e"},
    {"name": "ferocious bite", "type": "GetSpellTexture", "id": 22568, "key": "4"},
    {"name": "tiger's fury", "type": "GetSpellTexture", "id": 5217, "key": "6"},
    {"name": "barkskin", "type": "GetSpellTexture", "id": 22812, "key": "g"},
    {"name": "mangle", "type": "GetSpellTexture", "id": 33917, "key": "f3", "modifier": "ctrl"},
    {"name": "survival instincts", "type": "GetSpellTexture", "id": 61336, "key": "d", "modifier": "alt"},
    {"name": "lacerate", "type": "GetSpellTexture", "id": 33745, "key": "3"},
    {"name": "berserk", "type": "GetSpellTexture", "id": 50334, "key": "r", "modifier": "alt"},
]

skills["death knight"] = [
    {"name": "plague strike", "type": "GetSpellTexture", "id": 45462, "key": "1"},
    {"name": "icy touch", "type": "GetSpellTexture", "id": 45477, "key": "2"},
    {"name": "chains of ice", "type": "GetSpellTexture", "id": 45524, "key": "v"},
    {"name": "death strike", "type": "GetSpellTexture", "id": 45463, "key": "f2", "modifier": "ctrl"},
    {"name": "heart strike", "type": "GetSpellTexture", "id": 55050, "key": "f1", "modifier": "ctrl"},
    {"name": "death coil", "type": "GetSpellTexture", "id": 6789, "key": "4"},
    {"name": "blood boil", "type": "GetSpellTexture", "id": 48721, "key": "e"},
    {"name": "icebound fortitude", "type": "GetSpellTexture", "id": 48792, "key": "t"},
    {"name": "horn of winter", "type": "GetSpellTexture", "id": 57330, "key": "f4"},
    {"name": "pestilence", "type": "GetSpellTexture", "id": 50842, "key": "3"},
]

skills["priest"] = [
]

skills["paladin"] = [
    {"name": "blessing of might", "type": "GetSpellTexture", "id": 19740, "key": "f1"},
    {"name": "exorcism", "type": "GetSpellTexture", "id": 879, "key": "f1", "modifier": "ctrl"},
    {"name": "judgement of light", "type": "GetSpellTexture", "id": 20271, "key": "f2", "modifier": "ctrl"},
    {"name": "judgement of wisdom", "type": "GetSpellTexture", "id": 53408, "key": "f3", "modifier": "ctrl"},
    {"name": "lay on hands", "type": "GetSpellTexture", "id": 633, "key": "k"},
    {"name": "purify", "type": "GetSpellTexture", "id": 1152, "key": "t"},
    {"name": "divine protection", "type": "GetSpellTexture", "id": 498, "key": "r", "modifier": "alt"},
    {"name": "divine storm", "type": "GetSpellTexture", "id": 53385, "key": "4"},
    {"name": "crusader strike", "type": "GetSpellTexture", "id": 35395, "key": "5"},
    {"name": "consecration", "type": "GetSpellTexture", "id": 20116, "key": "3"},
    {"name": "seal of command", "type": "GetSpellTexture", "id": 20375, "key": "d", "modifier": "alt"},
    {"name": "seal of vengeance", "type": "GetSpellTexture", "id": 31801, "key": "f", "modifier": "alt"},
]

skills["shaman"] = [
]

skills["rogue"] = [
    {"name": "sinister strike", "type": "GetSpellTexture", "id": 1752, "key": "f2", "modifier": "ctrl"},
    {"name": "eviscerate", "type": "GetSpellTexture", "id": 2098, "key": "4"},
]
