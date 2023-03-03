

skills = dict()

skills["globals"] = [
    # {"name": "flame spike", "type": "GetSpellTexture", "id": 56091, "key": "1"},
    # {"name": "engulf in flames", "type": "GetSpellTexture", "id": 56092, "key": "2"},
]

skills["healing"] = [
    {"name": "healthstone", "type": "GetSpellTexture", "id": 5720,  "key": "4", "modifier": "lalt"},
    {"name": "healing potion", "type": "GetSpellTexture", "id": 28491, "key": "5", "modifier": "lalt"},
    {"name": "fel blossom", "type": "GetSpellTexture", "id": 28527, "key": "6", "modifier": "lalt"},
    {"name": "lifeblood", "type": "GetSpellTexture", "id": 55428, "key": "7", "modifier": "lalt"},
]

skills["offgcd"] = dict()
skills["offgcd"]["warrior"] = [
    {"name": "heroic strike", "type": "GetSpellTexture", "id": 78, "key": "2"},
    {"name": "cleave", "type": "GetSpellTexture", "id": 845, "key": "3"},
    {"name": "shield wall", "type": "GetSpellTexture", "id": 871, "key": "e", "modifier": "lalt"},
    {"name": "spell reflection", "type": "GetSpellTexture", "id": 23920, "key": "v"},
    {"name": "shield block", "type": "GetSpellTexture", "id": 2565, "key": "f4", "modifier": "lcontrol"},
    {"name": "last stand", "type": "GetSpellTexture", "id": 12975, "key": "t", "modifier": "lshift"},
    {"name": "battlemaster's resolve", "type": "GetItemIcon", "id": 41589, "key": "1", "modifier": "lalt"},
    {"name": "blood fury", "type": "GetSpellTexture", "id": 20572, "key": "8"},
    {"name": "bloodrage", "type": "GetSpellTexture", "id": 2687, "key": "f", "modifier": "lalt"},
    {"name": "gloves_trinket", "type": "GetSpellTexture", "id": 52766, "key": "t"},
]

skills["offgcd"]["druid"] = [
    {"name": "maul", "type": "GetSpellTexture", "id": 6807, "key": "1"},
    {"name": "nature's grasp", "type": "GetSpellTexture", "id": 16689, "key": "f", "modifier": "lalt"},
    {"name": "battlemaster's resolve", "type": "GetItemIcon", "id": 41589, "key": "1", "modifier": "lalt"},
]

skills["offgcd"]["death knight"] = [
    {"name": "battlemaster's resolve", "type": "GetItemIcon", "id": 41589, "key": "1", "modifier": "lalt"},
    {"name": "rune strike", "type": "GetSpellTexture", "id": 56815, "key": "7"},
    {"name": "rune tap", "type": "GetSpellTexture", "id": 48982, "key": "h"},
    {"name": "blood tap", "type": "GetSpellTexture", "id": 45529, "key": "0"},
    {"name": "anti-magic shell", "type": "GetSpellTexture", "id": 48707, "key": "g"},
    {"name": "empower rune weapon", "type": "GetSpellTexture", "id": 47568, "key": "8"},
    {"name": "vampiric blood", "type": "GetSpellTexture", "id": 55233, "key": "6"},
    {"name": "icebound fortitude", "type": "GetSpellTexture", "id": 48792, "key": "t"},
]

skills["offgcd"]["hunter"] = [
    {"name": "kill command", "type": "GetSpellTexture", "id": 34026, "key": "4"},
    {"name": "aspect of the hawk", "type": "GetSpellTexture", "id": 13165, "key": "f1"},
    {"name": "aspect of the dragonhawk", "type": "GetSpellTexture", "id": 61846, "key": "f1"},
    {"name": "aspect of the viper", "type": "GetSpellTexture", "id": 34074, "key": "f2"},
]

skills["offgcd"]["rogue"] = [
    {"name": "pick pocket", "type": "GetSpellTexture", "id": 921, "key": "f5", "modifier": "lcontrol"},
]

skills["offgcd"]["paladin"] = [
    {"name": "divine protection", "type": "GetSpellTexture", "id": 498, "key": "r", "modifier": "lalt"},
]

skills["offgcd"]["priest"] = []
skills["offgcd"]["warlock"] = []
skills["offgcd"]["shaman"] = []


skills["warrior"] = [
    {"name": "bloodthirst", "type": "GetSpellTexture", "id": 23881, "key": "f1", "modifier": "lcontrol"},
    {"name": "mortal strike", "type": "GetSpellTexture", "id": 12294, "key": "f1", "modifier": "lcontrol"},
    {"name": "revenge", "type": "GetSpellTexture", "id": 6572, "key": "f3", "modifier": "lcontrol"},
    {"name": "devastate", "type": "GetSpellTexture", "id": 20243, "key": "f2", "modifier": "lcontrol"},
    {"name": "slam", "type": "GetSpellTexture", "id": 47475, "key": "f2", "modifier": "lcontrol"},
    {"name": "berserker rage", "type": "GetSpellTexture", "id": 18499, "key": "f4", "modifier": "lcontrol"},
    {"name": "enraged regeneration", "type": "GetSpellTexture", "id": 55694, "key": "f5", "modifier": "lcontrol"},
    {"name": "rend", "type": "GetSpellTexture", "id": 772, "key": "r", "modifier": "lshift"},
    {"name": "victory rush", "type": "GetSpellTexture", "id": 34428, "key": "e", "modifier": "lshift"},
    {"name": "disarm", "type": "GetSpellTexture", "id": 676, "key": "e", "modifier": "lshift"},
    {"name": "vigilance", "type": "GetSpellTexture", "id": 50720, "key": "r", "modifier": "lshift"},
    {"name": "sweeping strikes", "type": "GetSpellTexture", "id": 12328, "key": "r", "modifier": "lalt"},
    {"name": "death wish", "type": "GetSpellTexture", "id": 12292, "key": "r", "modifier": "lalt"},
    {"name": "recklessness", "type": "GetSpellTexture", "id": 1719, "key": "e", "modifier": "lalt"},
    {"name": "battle shout", "type": "GetSpellTexture", "id": 2048, "key": "f10"},
    {"name": "commanding shout", "type": "GetSpellTexture", "id": 469, "key": "f6"},
    {"name": "demoralizing shout", "type": "GetSpellTexture", "id": 1160, "key": "f5"},
    {"name": "sunder armor", "type": "GetSpellTexture", "id": 7386, "key": "k"},
    {"name": "overpower", "type": "GetSpellTexture", "id": 7384, "key": "6"},
    {"name": "execute", "type": "GetSpellTexture", "id": 5308, "key": "f"},
    {"name": "whirlwind", "type": "GetSpellTexture", "id": 1680, "key": "6"},
    {"name": "thunder clap", "type": "GetSpellTexture", "id": 6343, "key": "e"},
    {"name": "shield slam", "type": "GetSpellTexture", "id": 23922, "key": "4"},
    {"name": "concussion blow", "type": "GetSpellTexture", "id": 12809, "key": "8"},
    {"name": "hamstring", "type": "GetSpellTexture", "id": 1715, "key": "1"},
    {"name": "shattering throw", "type": "GetSpellTexture", "id": 64382, "key": "7"},
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
    {"name": "serpent sting", "type": "GetSpellTexture", "id": 1978, "key": "f3", "modifier": "lcontrol"},
    {"name": "viper sting", "type": "GetSpellTexture", "id": 3034, "key": "f4", "modifier": "lcontrol"},
    {"name": "multi-shot", "type": "GetSpellTexture", "id": 2643, "key": "f1", "modifier": "lcontrol"},
    {"name": "arcane shot", "type": "GetSpellTexture", "id": 3044, "key": "f2", "modifier": "lcontrol"},
    {"name": "chimera shot", "type": "GetSpellTexture", "id": 53209, "key": "3"},
    {"name": "aimed shot", "type": "GetSpellTexture", "id": 19434, "key": "6"},
    {"name": "deterrence", "type": "GetSpellTexture", "id": 19263, "key": "t", "modifier": "lshift"},
    {"name": "trueshot aura", "type": "GetSpellTexture", "id": 19506, "key": "1", "modifier": "lalt"},
    {"name": "wing clip", "type": "GetSpellTexture", "id": 2974, "key": "1", "modifier": "lalt"},
    {"name": "hunter's mark", "type": "GetSpellTexture", "id": 1130, "key": "3", "modifier": "lalt"},
    {"name": "mend pet", "type": "GetSpellTexture", "id": 136, "key": "v"},
    {"name": "cower pet", "type": "GetSpellTexture", "id": 1742, "key": "4", "modifier": "lcontrol"},
    {"name": "last stand pet", "type": "GetSpellTexture", "id": 53478, "key": "5", "modifier": "lcontrol"},
    {"name": "kill shot", "type": "GetSpellTexture", "id": 53351, "key": "e"},
    {"name": "explosive shot", "type": "GetSpellTexture", "id": 60052, "key": "3"},
    {"name": "black arrow", "type": "GetSpellTexture", "id": 63671, "key": "5"},
    {"name": "explosive trap", "type": "GetSpellTexture", "id": 49066, "key": "g"},
    {"name": "misdirection", "type": "GetSpellTexture", "id": 34477, "key": "2", "modifier": "lalt"},
    {"name": "tranquilizing shot", "type": "GetSpellTexture", "id": 19801, "key": "k"},
]

skills["druid"] = [
    {"name": "swipe", "type": "GetSpellTexture", "id": 50256, "key": "2"},
    {"name": "demoralizing roar", "type": "GetSpellTexture", "id": 99, "key": "3", "modifier": "lalt"},
    {"name": "claw", "type": "GetSpellTexture", "id": 1082, "key": "1"},
    {"name": "shred", "type": "GetSpellTexture", "id": 5221, "key": "8"},
    {"name": "rip", "type": "GetSpellTexture", "id": 1079, "key": "5"},
    {"name": "rake", "type": "GetSpellTexture", "id": 1822, "key": "3"},
    {"name": "faerie fire", "type": "GetSpellTexture", "id": 770, "key": "e"},
    {"name": "ferocious bite", "type": "GetSpellTexture", "id": 22568, "key": "4"},
    {"name": "tiger's fury", "type": "GetSpellTexture", "id": 5217, "key": "6"},
    {"name": "barkskin", "type": "GetSpellTexture", "id": 22812, "key": "g"},
    {"name": "mangle", "type": "GetSpellTexture", "id": 33917, "key": "f2", "modifier": "lcontrol"},
    {"name": "survival instincts", "type": "GetSpellTexture", "id": 61336, "key": "d", "modifier": "lalt"},
    {"name": "lacerate", "type": "GetSpellTexture", "id": 33745, "key": "3"},
    {"name": "berserk", "type": "GetSpellTexture", "id": 50334, "key": "r", "modifier": "lalt"},
    {"name": "savage roar", "type": "GetSpellTexture", "id": 52610, "key": "e", "modifier": "lshift"},
    {"name": "swiftmend", "type": "GetSpellTexture", "id": 18562, "key": "2"},
    {"name": "thorns", "type": "GetSpellTexture", "id": 53307, "key": "6"},
    {"name": "lifebloom", "type": "GetSpellTexture", "id": 48451, "key": "7"},
    {"name": "rejuvenation", "type": "GetSpellTexture", "id": 48441, "key": "8"},
]

skills["death knight"] = [
    {"name": "plague strike", "type": "GetSpellTexture", "id": 45462, "key": "1"},
    {"name": "icy touch", "type": "GetSpellTexture", "id": 45477, "key": "2"},
    {"name": "chains of ice", "type": "GetSpellTexture", "id": 45524, "key": "v"},
    {"name": "death strike", "type": "GetSpellTexture", "id": 45463, "key": "f2", "modifier": "lcontrol"},
    {"name": "heart strike", "type": "GetSpellTexture", "id": 55050, "key": "f1", "modifier": "lcontrol"},
    {"name": "death coil", "type": "GetSpellTexture", "id": 6789, "key": "4"},
    {"name": "blood boil", "type": "GetSpellTexture", "id": 48721, "key": "e"},
    {"name": "horn of winter", "type": "GetSpellTexture", "id": 57330, "key": "f10"},
    {"name": "pestilence", "type": "GetSpellTexture", "id": 50842, "key": "3"},
    {"name": "death and decay", "type": "GetSpellTexture", "id": 49936, "key": "r", "modifier": "lalt"},
    {"name": "howling blast", "type": "GetSpellTexture", "id": 51410, "key": "9"},
    {"name": "obliterate", "type": "GetSpellTexture", "id": 51424, "key": "5"},
    {"name": "frost strike", "type": "GetSpellTexture", "id": 51419, "key": "6"},
    {"name": "unbreakable armor", "type": "GetSpellTexture", "id": 51271, "key": "h"},
    {"name": "blood strike", "type": "GetSpellTexture", "id": 49929, "key": "f5", "modifier": "lcontrol"},
    {"name": "mark of blood", "type": "GetSpellTexture", "id": 49005, "key": "k"},
    {"name": "raise dead", "type": "GetSpellTexture", "id": 46584, "key": "f", "modifier": "lalt"},
]

skills["paladin"] = [
    {"name": "righteous fury", "type": "GetSpellTexture", "id": 25780, "key": "f5", "modifier": "lcontrol"},
    {"name": "divine storm", "type": "GetSpellTexture", "id": 53385, "key": "4"},
    {"name": "crusader strike", "type": "GetSpellTexture", "id": 35395, "key": "5"},
    {"name": "exorcism", "type": "GetSpellTexture", "id": 879, "key": "f3", "modifier": "lcontrol"},
    {"name": "judgement of light", "type": "GetSpellTexture", "id": 20271, "key": "f1", "modifier": "lcontrol"},
    {"name": "judgement of wisdom", "type": "GetSpellTexture", "id": 53408, "key": "f2", "modifier": "lcontrol"},
    {"name": "lay on hands", "type": "GetSpellTexture", "id": 633, "key": "k"},
    {"name": "purify", "type": "GetSpellTexture", "id": 1152, "key": "t"},
    {"name": "cleanse", "type": "GetSpellTexture", "id": 4987, "key": "t"},
    {"name": "consecration", "type": "GetSpellTexture", "id": 20116, "key": "2"},
    {"name": "seal of command", "type": "GetSpellTexture", "id": 20375, "key": "f", "modifier": "lalt"},
    # {"name": "seal of vengeance", "type": "GetSpellTexture", "id": 31801, "key": "d", "modifier": "lalt"},
    # {"name": "seal of righteousness", "type": "GetSpellTexture", "id": 21084, "key": "d", "modifier": "lalt"},
    {"name": "holy shield", "type": "GetSpellTexture", "id": 20925, "key": "3"},
    {"name": "avengers shield", "type": "GetSpellTexture", "id": 31935, "key": "f4", "modifier": "lcontrol"},
    {"name": "hammer of the righteous", "type": "GetSpellTexture", "id": 53595, "key": "4"},
    {"name": "shield of righteousness", "type": "GetSpellTexture", "id": 61411, "key": "5"},
    {"name": "holy wrath", "type": "GetSpellTexture", "id": 48817, "key": "7"},
    {"name": "hammer of wrath", "type": "GetSpellTexture", "id": 24275, "key": "8"},
    {"name": "beacon of light", "type": "GetSpellTexture", "id": 53563, "key": "f5", "modifier": "lcontrol"},
    {"name": "divine sacrifice", "type": "GetSpellTexture", "id": 64205, "key": "6"},
    {"name": "holy light", "type": "GetSpellTexture", "id": 27136, "key": "e"},
]

skills["rogue"] = [
    {"name": "sinister strike", "type": "GetSpellTexture", "id": 1752, "key": "f1", "modifier": "lcontrol"},
    {"name": "eviscerate", "type": "GetSpellTexture", "id": 2098, "key": "4"},
]

skills["shaman"] = [
    {"name": "lighning bolt", "type": "GetSpellTexture", "id": 403, "key": "1"},
    {"name": "healing wave", "type": "GetSpellTexture", "id": 331, "key": "e"},
    {"name": "lightning shield", "type": "GetSpellTexture", "id": 324, "key": "k"},
    {"name": "rockbiter weapon", "type": "GetSpellTexture", "id": 8017, "key": "f1"},
    {"name": "flametongue weapon", "type": "GetSpellTexture", "id": 8024, "key": "f2"},
    {"name": "flame shock", "type": "GetSpellTexture", "id": 8050, "key": "4"},
]
skills["priest"] = []

color = dict()
color["#ff9f13"] = "druid"
color["#ffffff"] = "priest"
color["#dfb990"] = "warrior"
color["#c8e795"] = "hunter"
color["#a8a6fd"] = "warlock"
color["#dd365a"] = "death knight"
color["#ffacd4"] = "paladin"
color["#ffff8b"] = "rogue"
color["#0092f1"] = "shaman"

monitor_settings = dict()
monitor_settings["3840"] = {
    "x": 15,
    "y": 15,
    "c_width": 7,
    "c_height": 7,
    "p_offgcd_left": 21,
    "p_combat_left": 39,
    "p_interrupt_left": 57,
    "p_behind_left": 74,
    "p_clss_left": 88
}
monitor_settings["2560"] = {
    "x": 8,
    "y": 8,
    "c_width": 5,
    "c_height": 5,
    "p_offgcd_left": 15,
    "p_combat_left": 26,
    "p_interrupt_left": 37,
    "p_behind_left": 47,
    "p_clss_left": 60,
    "p_aoe_left": 254,
}
monitor_settings["3072"] = {
    "x": 12,
    "y": 12,
    "c_width": 5,
    "c_height": 5,
    "p_offgcd_left": 19,
    "p_combat_left": 40,
    "p_interrupt_left": 54,
    "p_behind_left": 64,
    "p_clss_left": 77,
}
monitor_settings["2048.0"] = {
    "x": 8,
    "y": 8,
    "c_width": 5,
    "c_height": 5,
    "p_offgcd_left": 13,
    "p_aoe_left": 160,
    "p_combat_left": 24,
    "p_interrupt_left": 33,
    "p_behind_left": 43,
    "p_clss_left": 52,
}
monitor_settings["1440.0"] = {
    "x": 5,
    "y": 5,
    "c_width": 5,
    "c_height": 5,
    "p_offgcd_left": 9,
    "p_combat_left": 17,
    "p_interrupt_left": 24,
    "p_behind_left": 31,
    "p_clss_left": 37,
}


keyCodeMap = {
    "ESCAPE": "0x01",
    "1": "0x02",
    "2": "0x03",
    "3": "0x04",
    "4": "0x05",
    "5": "0x06",
    "6": "0x07",
    "7": "0x08",
    "8": "0x09",
    "9": "0x0A",
    "0": "0x0B",
    "MINUS": "0x0C",
    "EQUALS": "0x0D",
    "BACK": "0x0E",
    "TAB": "0x0F",
    "Q": "0x10",
    "W": "0x11",
    "E": "0x12",
    "R": "0x13",
    "T": "0x14",
    "Y": "0x15",
    "U": "0x16",
    "I": "0x17",
    "O": "0x18",
    "P": "0x19",
    "LBRACKET": "0x1A",
    "RBRACKET": "0x1B",
    "RETURN": "0x1C",
    "LCONTROL": "0x1D",
    "A": "0x1E",
    "S": "0x1F",
    "D": "0x20",
    "F": "0x21",
    "G": "0x22",
    "H": "0x23",
    "J": "0x24",
    "K": "0x25",
    "L": "0x26",
    "SEMICOLON": "0x27",
    "APOSTROPHE": "0x28",
    "GRAVE": "0x29",
    "LSHIFT": "0x2A",
    "BACKSLASH": "0x2B",
    "Z": "0x2C",
    "X": "0x2D",
    "C": "0x2E",
    "V": "0x2F",
    "B": "0x30",
    "N": "0x31",
    "M": "0x32",
    "COMMA": "0x33",
    "PERIOD": "0x34",
    "SLASH": "0x35",
    "RSHIFT": "0x36",
    "MULTIPLY": "0x37",
    "LALT": "0x38",
    "SPACE": "0x39",
    "CAPITAL": "0x3A",
    "F1": "0x3B",
    "F2": "0x3C",
    "F3": "0x3D",
    "F4": "0x3E",
    "F5": "0x3F",
    "F6": "0x40",
    "F7": "0x41",
    "F8": "0x42",
    "F9": "0x43",
    "F10": "0x44",
    "NUMLOCK": "0x45",
    "SCROLL": "0x46",
    "NUMPAD7": "0x47",
    "NUMPAD8": "0x48",
    "NUMPAD9": "0x49",
    "SUBTRACT": "0x4A",
    "NUMPAD4": "0x4B",
    "NUMPAD5": "0x4C",
    "NUMPAD6": "0x4D",
    "ADD": "0x4E",
    "NUMPAD1": "0x4F",
    "NUMPAD2": "0x50",
    "NUMPAD3": "0x51",
    "NUMPAD0": "0x52",
    "DECIMAL": "0x53",
    "F11": "0x57",
    "F12": "0x58",
    "F13": "0x64",
    "F14": "0x65",
    "F15": "0x66",
    "KANA": "0x70",
    "CONVERT": "0x79",
    "NOCONVERT": "0x7B",
    "YEN": "0x7D",
    "NUMPADEQUALS": "0x8D",
    "CIRCUMFLEX": "0x90",
    "AT": "0x91",
    "COLON": "0x92",
    "UNDERLINE": "0x93",
    "KANJI": "0x94",
    "STOP": "0x95",
    "AX": "0x96",
    "UNLABELED": "0x97",
    "NUMPADENTER": "0x9C",
    "RCONTROL": "0x9D",
    "NUMPADCOMMA": "0xB3",
    "DIVIDE": "0xB5",
    "SYSRQ": "0xB7",
    "RALT": "0xB8",
    "PAUSE": "0xC5",
    "HOME": "0xC7",
    "UP": "0xC8",
    "PRIOR": "0xC9",
    "LEFT": "0xCB",
    "RIGHT": "0xCD",
    "END": "0xCF",
    "DOWN": "0xD0",
    "NEXT": "0xD1",
    "INSERT": "0xD2",
    "DELETE": "0xD3",
    "LWIN": "0xDB",
    "RWIN": "0xDC",
    "APPS": "0xDD",
    "POWER": "0xDE",
    "SLEEP": "0xDF"
}
