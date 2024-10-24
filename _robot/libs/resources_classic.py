data = dict()

data = {
    "colors": {
        "shaman": {"#0092f1", "#4090ea", "#3d7aff"},
        "warrior": {"#dfb990", "#e7c49b"},
        "druid": {"#ff9f13", "#ffa91e"},
        "death knight": {"#dd365a", "#e44266"},
        "hunter": {"#c8e795", "#d0f1a0"},
        "rogue": {"#ffff8b", "#ffff96"},
        "paladin": {"#ffacd4", "#ffb6dc"},
        "warlock": {"#a8a6fd"},
        "priest": {"#ffffff"},
    },
    "globals": [],
    "healing": [
        {"name": "healing potion", "type": "GetSpellTexture", "id": 29203, "key": "7", "modifier": "lalt"},
        {"name": "healthstone", "type": "GetSpellTexture", "id": 5720, "key": "6", "modifier": "lalt"},
    ],
    "shaman": {
        "main": [
            {"name": "stormstrike", "type": "GetSpellTexture", "id": 17364, "key": "1"},
            {"name": "lightning bolt", "type": "GetSpellTexture", "id": 403, "key": "2"},
            {"name": "chain ligtning", "type": "GetSpellTexture", "id": 421, "key": "3"},
            {"name": "healing wave mouseover", "type": "GetSpellTexture", "id": 443464, "key": "e"},
            {"name": "healing wave player", "type": "GetSpellTexture", "id": 331, "key": "2", "modifier": "lshift"},
            {"name": "healing wave tot", "type": "GetSpellTexture", "id": 14913, "key": "3", "modifier": "lshift"},
            {"name": "lightning shield", "type": "GetSpellTexture", "id": 324, "key": "v"},
            {"name": "water shield", "type": "GetSpellTexture", "id": 408510, "key": "7"},
            {"name": "molten blast", "type": "GetSpellTexture", "id": 425339, "key": "3"},
            {"name": "flame shock", "type": "GetSpellTexture", "id": 8050, "key": "4"},
            {"name": "frost shock", "type": "GetSpellTexture", "id": 8056, "key": "5"},
            {"name": "earth shock", "type": "GetSpellTexture", "id": 8045, "key": "6"},
            {"name": "cure toxins", "type": "GetSpellTexture", "id": 526, "key": "t"},
            {"name": "lava lash", "type": "GetSpellTexture", "id": 408507, "key": "7"},
            {"name": "rockbiter weapon mh", "type": "GetSpellTexture", "id": 8017, "key": "f1"},
            {"name": "windfury weapon mh", "type": "GetSpellTexture", "id": 8232, "key": "f2"},
            {"name": "flametongue weapon mh", "type": "GetSpellTexture", "id": 8024, "key": "f3"},
            {"name": "rockbiter weapon oh", "type": "GetItemIcon", "id": 1483, "modifier": "lshift", "key": "f1"},
            {"name": "windfury weapon oh", "type": "GetItemIcon", "id": 215373, "modifier": "lshift", "key": "f2"},
            {"name": "flametongue weapon oh", "type": "GetItemIcon", "id": 924, "modifier": "lshift", "key": "f3"},
            {"name": "purge", "type": "GetSpellTexture", "id": 370, "key": "8"},
        ],
        "secondary": [
            {"name": "shamanistic rage", "type": "GetSpellTexture", "id": 425336, "key": "6"},
            # {"name": "totem fire nova", "type": "GetSpellTexture", "id": 1535, "modifier": "lshift", "key": "2"},
            # {"name": "totem searing", "type": "GetSpellTexture", "id": 3599, "modifier": "lshift", "key": "1"},
        ],
    },
    "warrior": {
        "main": [
            {"name": "bloodthirst", "type": "GetSpellTexture", "id": 23881, "key": "1", "modifier": "lshift"},
            {"name": "mortal strike", "type": "GetSpellTexture", "id": 12294, "key": "5"},
            {"name": "revenge", "type": "GetSpellTexture", "id": 6572, "key": "3", "modifier": "lshift"},
            {"name": "hamstring", "type": "GetSpellTexture", "id": 1715, "key": "3", "modifier": "lshift"},
            {"name": "berserker rage", "type": "GetSpellTexture", "id": 18499, "key": "4", "modifier": "lshift"},
            {"name": "rend", "type": "GetSpellTexture", "id": 772, "key": "r", "modifier": "lshift"},
            {"name": "sweeping strikes", "type": "GetSpellTexture", "id": 12292, "key": "r", "modifier": "lalt"},
            {"name": "battle shout", "type": "GetSpellTexture", "id": 6673, "key": "f10"},
            {"name": "demoralizing shout", "type": "GetSpellTexture", "id": 1160, "key": "f5"},
            {"name": "sunder armor", "type": "GetSpellTexture", "id": 7386, "key": "k"},
            {"name": "overpower", "type": "GetSpellTexture", "id": 7384, "key": "7"},
            {"name": "execute", "type": "GetSpellTexture", "id": 5308, "key": "8"},
            {"name": "whirlwind", "type": "GetSpellTexture", "id": 1680, "key": "6"},
            {"name": "thunder clap", "type": "GetSpellTexture", "id": 6343, "key": "e"},
            {"name": "shield slam", "type": "GetSpellTexture", "id": 23922, "key": "4"},
            {"name": "victory rush", "type": "GetSpellTexture", "id": 402927, "key": "e", "modifier": "lshift"},
            {"name": "quick strike", "type": "GetSpellTexture", "id": 429765, "key": "e", "modifier": "lshift"},
            {"name": "slam", "type": "GetSpellTexture", "id": 1464, "key": "1", "modifier": "lalt"},
            {"name": "commanding shout", "type": "GetSpellTexture", "id": 403215, "key": "f6"},
            {"name": "enraged regeneration", "type": "GetSpellTexture", "id": 402913, "key": "d", "modifier": "lalt"},
            # {"name": "devastate", "type": "GetSpellTexture", "id": 20243, "key": "2", "modifier": "lshift"},
            # {"name": "disarm", "type": "GetSpellTexture", "id": 676, "key": "e", "modifier": "lshift"},
            # {"name": "vigilance", "type": "GetSpellTexture", "id": 50720, "key": "r", "modifier": "lshift"},
            # {"name": "death wish", "type": "GetSpellTexture", "id": 12292, "key": "r", "modifier": "lalt"},
            # {"name": "recklessness", "type": "GetSpellTexture", "id": 1719, "key": "e", "modifier": "lalt"},
            # {"name": "concussion blow", "type": "GetSpellTexture", "id": 12809, "key": "8"},
            # {"name": "shattering throw", "type": "GetSpellTexture", "id": 64382, "key": "7"},
        ],
        "secondary": [
            {"name": "shield block", "type": "GetSpellTexture", "id": 2565, "key": "5", "modifier": "lshift"},
            {"name": "last stand", "type": "GetSpellTexture", "id": 12975, "key": "t", "modifier": "lshift"},
            {"name": "shield wall", "type": "GetSpellTexture", "id": 871, "key": "e", "modifier": "lalt"},
            {"name": "bloodrage", "type": "GetSpellTexture", "id": 2687, "key": "f", "modifier": "lalt"},
            {"name": "heroic strike", "type": "GetSpellTexture", "id": 78, "key": "2"},
            {"name": "cleave", "type": "GetSpellTexture", "id": 845, "key": "3"},
            {"name": "spell reflection", "type": "GetSpellTexture", "id": 23920, "key": "v"},
            {"name": "blood fury", "type": "GetSpellTexture", "id": 20572, "key": "8"},
            # {"name": "gloves_trinket", "type": "GetSpellTexture", "id": 52766, "key": "t"},
        ],
    },
    "druid": {
        "main": [
            {"name": "wrath", "type": "GetSpellTexture", "id": 5176, "key": "1"},
            {"name": "healing touch", "type": "GetSpellTexture", "id": 5185, "key": "e"},
            {"name": "lifebloom", "type": "GetSpellTexture", "id": 408124, "key": "x"},
            {"name": "mark of the wild", "type": "GetSpellTexture", "id": 1126, "key": "f10"},
            {"name": "thorns", "type": "GetSpellTexture", "id": 467, "key": "5", "modifier": "lshift"},
            {"name": "sunfire", "type": "GetSpellTexture", "id": 414684, "key": "3"},
            {"name": "faerie fire", "type": "GetSpellTexture", "id": 770, "key": "e"},
            {"name": "claw", "type": "GetSpellTexture", "id": 1082, "key": "1"},
            {"name": "mangle", "type": "GetSpellTexture", "id": 407995, "key": "1"},
            {"name": "shred", "type": "GetSpellTexture", "id": 5221, "key": "2"},
            {"name": "rake", "type": "GetSpellTexture", "id": 1822, "key": "3"},
            {"name": "rip", "type": "GetSpellTexture", "id": 1079, "key": "5"},
            {"name": "savage roar", "type": "GetSpellTexture", "id": 407988, "key": "6"},
            {"name": "ferocious bite", "type": "GetSpellTexture", "id": 22568, "key": "4"},
            {"name": "tiger's fury", "type": "GetSpellTexture", "id": 5217, "key": "7"},
            {"name": "demoralizing roar", "type": "GetSpellTexture", "id": 1735, "key": "8"},
        ],
        "secondary": [
            {"name": "maul", "type": "GetSpellTexture", "id": 6807, "key": "2"},
            {"name": "swipe", "type": "GetSpellTexture", "id": 779, "key": "3"},
            # {"name": "nature's grasp", "type": "GetSpellTexture", "id": 16689, "key": "f", "modifier": "lalt"},
        ],
    },
    "hunter": {
        "main": [
            # {"name": "auto attack", "type": "GetSpellTexture", "id": 674, "key": "1", "modifier": "lalt"},
            {"name": "auto attack", "type": "GetSpellTexture", "id": 674, "key": "8"},
            # {"name": "auto shot", "type": "GetSpellTexture", "id": 6660, "key": "2", "modifier": "lalt"},
            {"name": "auto shot", "type": "GetSpellTexture", "id": 6660, "key": "8"},
            {"name": "trueshot aura", "type": "GetSpellTexture", "id": 19506, "key": "1", "modifier": "lalt"},
            {"name": "hunter's mark", "type": "GetSpellTexture", "id": 1130, "key": "3", "modifier": "lalt"},
            {"name": "mongoose bite", "type": "GetSpellTexture", "id": 1495, "key": "9"},
            {"name": "intimidation", "type": "GetSpellTexture", "id": 19577, "key": "t", "modifier": "lshift"},
            {"name": "multi-shot", "type": "GetSpellTexture", "id": 2643, "key": "3"},
            {"name": "arcane shot", "type": "GetSpellTexture", "id": 3044, "key": "2"},
            {"name": "serpent sting", "type": "GetSpellTexture", "id": 1978, "key": "4"},
            {"name": "concussive shot", "type": "GetSpellTexture", "id": 5116, "key": "1"},
            {"name": "mend pet", "type": "GetSpellTexture", "id": 136, "key": "v"},
            {"name": "disengage", "type": "GetSpellTexture", "id": 781, "key": "tab"},
            {"name": "tranquilizing shot", "type": "GetSpellTexture", "id": 19801, "key": "k"},
            {"name": "wing clip", "type": "GetSpellTexture", "id": 2974, "key": "7"},
            {"name": "raptor strike", "type": "GetSpellTexture", "id": 2973, "key": "6"},
            {"name": "explosive shot", "type": "GetSpellTexture", "id": 409552, "key": "9"},
            {"name": "chimera shot", "type": "GetSpellTexture", "id": 409433, "key": "9"},
            {"name": "carve", "type": "GetSpellTexture", "id": 425711, "key": "9"},
            {"name": "flanking strike", "type": "GetSpellTexture", "id": 415320, "key": "k"},
            {"name": "kill command", "type": "GetSpellTexture", "id": 409379, "key": "k"},
            {"name": "bestial wrath", "type": "GetSpellTexture", "id": 19574, "key": "5"},
        ],
        "secondary": [
            # {"name": "aspect of the hawk", "type": "GetSpellTexture", "id": 13165, "key": "f1"},
            # {"name": "aspect of the dragonhawk", "type": "GetSpellTexture", "id": 61846, "key": "f1"},
            # {"name": "aspect of the viper", "type": "GetSpellTexture", "id": 34074, "key": "f2"},
        ],
    },
    "rogue": {
        "main": [
            {"name": "sinister strike", "type": "GetSpellTexture", "id": 1752, "key": "1"},
            {"name": "ambush", "type": "GetSpellTexture", "id": 462720, "key": "0"},
            {"name": "backstab", "type": "GetSpellTexture", "id": 8721, "key": "2"},
            {"name": "saber slash", "type": "GetSpellTexture", "id": 424785, "key": "2"},
            {"name": "mutilate", "type": "GetSpellTexture", "id": 399956, "key": "2"},
            {"name": "gouge", "type": "GetSpellTexture", "id": 1776, "key": "f"},
            {"name": "eviscerate", "type": "GetSpellTexture", "id": 2098, "key": "5"},
            {"name": "slice and dice", "type": "GetSpellTexture", "id": 5171, "key": "6"},
            {"name": "between the eyes", "type": "GetSpellTexture", "id": 400009, "key": "7"},
            {"name": "blade dance", "type": "GetSpellTexture", "id": 400012, "key": "7"},
            {"name": "envenom", "type": "GetSpellTexture", "id": 399963, "key": "7"},
            {"name": "riposte", "type": "GetSpellTexture", "id": 14251, "key": "1", "modifier": "lalt"},
            {"name": "shuriken toss", "type": "GetSpellTexture", "id": 399986, "key": "3", "modifier": "lshift"},
            {"name": "blade flurry", "type": "GetSpellTexture", "id": 13877, "key": "2", "modifier": "lalt"},
            {"name": "expose armor", "type": "GetSpellTexture", "id": 8650, "key": "1", "modifier": "lalt"},
        ],
        "secondary": [
            # {"name": "pick pocket", "type": "GetSpellTexture", "id": 921, "key": "5", "modifier": "lshift"},
        ],
    },
    "warlock": {
        "main": [
            {"name": "immolate", "type": "GetSpellTexture", "id": 348, "key": "h"},
            {"name": "corruption", "type": "GetSpellTexture", "id": 172, "key": "v"},
            {"name": "curse of agony", "type": "GetSpellTexture", "id": 980, "key": "g"},
            {"name": "shadow bolt", "type": "GetSpellTexture", "id": 686, "key": "2"},
            {"name": "incinerate", "type": "GetSpellTexture", "id": 412758, "key": "3", "modifier": "lshift"},
            {"name": "chaos bolt", "type": "GetSpellTexture", "id": 403629, "key": "2", "modifier": "lshift"},
            {"name": "drain soul", "type": "GetSpellTexture", "id": 1120, "key": "e"},
            {"name": "drain life", "type": "GetSpellTexture", "id": 689, "key": "5"},
        ],
        "secondary": [],
    },
    "priest": {
        "main": [
            {"name": "shoot", "type": "GetSpellTexture", "id": 6660, "key": "1"},
            {"name": "shadow word pain", "type": "GetSpellTexture", "id": 589, "modifier": "lshift", "key": "1"},
            {"name": "homunculi", "type": "GetSpellTexture", "id": 402799, "key": "4"},
            {"name": "power word shield", "type": "GetSpellTexture", "id": 17, "key": "h"},
            {"name": "void plague", "type": "GetSpellTexture", "id": 425204, "key": "3"},
            {"name": "renew", "type": "GetSpellTexture", "id": 139, "key": "g"},
            {"name": "cure disease", "type": "GetSpellTexture", "id": 528, "key": "t"},
            {"name": "dispel magic", "type": "GetSpellTexture", "id": 527, "key": "t", "modifier": "lshift"},
            {"name": "mind blast", "type": "GetSpellTexture", "id": 8092, "key": "2", "modifier": "lshift"},
            # {"name": "devouring plague", "type": "GetSpellTexture", "id": 2944, "key": "9"},
            # {"name": "shadow word pain mouseover", "type": "GetSpellTexture", "id": 47948, "key": "1", "modifier": "lshift"},
            # {"name": "smite", "type": "GetSpellTexture", "id": 591, "key": "5", "modifier": "lshift"},
            # {"name": "heal", "type": "GetSpellTexture", "id": 2054, "key": "e"},
            # {"name": "inner fire", "type": "GetSpellTexture", "id": 588, "key": "f6"},
            # {"name": "power word fortitude", "type": "GetSpellTexture", "id": 1244, "key": "f1"},
            # {"name": "mind flay", "type": "GetSpellTexture", "id": 15407, "key": "2"},
            # {"name": "holy nova", "type": "GetSpellTexture", "id": 15237, "key": "8"},
        ],
        "secondary": [],
    },
}

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
    "p_clss_left": 88,
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
    "SLEEP": "0xDF",
}

keyCodeMap_OSX = {"LCONTROL": "ctrl", "LALT": "alt", "LSHIFT": "shift"}
