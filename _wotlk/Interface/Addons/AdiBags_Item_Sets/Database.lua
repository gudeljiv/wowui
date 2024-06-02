local _, addon = ...
-- local L = addon.L

local level = LE_EXPANSION_LEVEL_CURRENT

local db = {}

-- if level >= # then -- EXPANSION
--     db.EXPANSION = {
--         ["Armor"] = {
--             ["PVE"] = {
--                 ["Tier"] = {
--                     ["Set Name"] = {
--                     }
--                 },
--             },
--             ["PVP"] = {
--                 ["Honor"] = {
--                     ["Set Name"] = {
--                     }
--                 },
--                 ["Arena"] = {
--                     ["Set Name"] = {
--                     }
--                 },
--             },
--         },
--         ["Weapons"] = {
--             ["PVE"] = {
--                 ["Tier"] = {
--                     ["Set Name"] = {
--                     }
--                 },
--             },
--             ["PVP"] = {
--                 ["Honor"] = {
--                     ["Set Name"] = {
--                     }
--                 },
--                 ["Arena"] = {
--                     ["Set Name"] = {
--                     }
--                 },
--             },
--         }
--     }
-- end

if level >= 0 then -- Vanilla / Classic Era
    db.Vanilla = {
        ["Armor"] = {
            ["PVE"] = {
                ["Dungeon"] = {
                    ["Dungeon Set 1"] = {
                        16686,16689,16688,16683,16684,16685,16687,16682, -- Magister's Regalia
                        16693,16695,16690,16697,16692,16696,16694,16691, -- Vestments of the Devout
                        16698,16701,16700,16703,16705,16702,16699,16704, -- Dreadmist Raiment
                        16707,16708,16721,16710,16712,16713,16709,16711, -- Shadowcraft Armor
                        16720,16718,16706,16714,16717,16716,16719,16715, -- Wildheart Raiment
                        16677,16679,16674,16681,16676,16680,16678,16675, -- Beaststalker Armor
                        16667,16669,16666,16671,16672,16673,16668,16670, -- The Elements
                        16727,16729,16726,16722,16724,16723,16728,16725, -- Lightforge Armor
                        16731,16733,16730,16735,16737,16736,16732,16734, -- Battlegear of Valor
                    },
                    ["Dungeon Set 2"] = {
                        21999,22001,21997,21996,21998,21994,22000,21995, -- Battlegear of Heroism
                        22005,22008,22009,22004,22006,22002,22007,22003, -- Darkmantle Armor
                        22109,22112,22113,22108,22110,22106,22111,22107, -- Feralheart Raiment
                        22080,22082,22083,22079,22081,22078,22085,22084, -- Vestments of the Virtuous
                        22013,22016,22060,22011,22015,22010,22017,22061, -- Beastmaster Armor
                        22091,22093,22089,22088,22090,22086,22092,22087, -- Soulforge Armor
                        22065,22068,22069,22063,22066,22062,22067,22064, -- Sorcerer's Regalia
                        22074,22073,22075,22071,22077,22070,22072,22076, -- Deathmist Raiment
                        22097,22101,22102,22095,22099,22098,22100,22096, -- The Five Thunders
                    },
                    ["Dungeon Set 3"] = {
                        27509,28414,27908,27776,28204, -- Assassination Armor
                        27936,28401,27528,28192,27713, -- Desolation Battlegear
                        28278,27508,27738,28229,27838, -- Incanter's Regalia
                        28231,27510,28349,27909,27802, -- Tidefury Raiment
                        28413,28230,27536,27775,27875, -- Hallowed Raiment
                        28348,27468,27873,28202,27737, -- Moonglade Raiment
                        28264,27531,28224,27837,27797, -- Wastewalker Armor
                        28203,27535,28285,27839,27739, -- Righteous Armor
                        27537,28415,28232,27778,27948, -- Oblivion Raiment
                        28193,27465,27907,28191,27796, -- Mana-Etched Regalia
                        28205,27475,27977,27803,28350, -- Bold Armor
                        28228,27474,28275,27874,27801, -- Beast Lord Armor
                        28403,27497,28225,27870,27771, -- Doomplate Battlegear
                    },
                },
                ["Tier"] = {
                    ["Tier 1 Raid Set"] = {
                        16795,16797,16798,16799,16801,16802,16796,16800, -- Arcanist Regalia
                        16813,16816,16815,16819,16812,16817,16814,16811, -- Vestments of Prophecy
                        16808,16807,16809,16804,16805,16806,16810,16803, -- Felheart Raiment
                        16821,16823,16820,16825,16826,16827,16822,16824, -- Nightslayer Armor
                        16834,16836,16833,16830,16831,16828,16835,16829, -- Cenarion Raiment
                        16846,16848,16845,16850,16852,16851,16847,16849, -- Giantstalker Armor
                        16842,16844,16841,16840,16839,16838,16843,16837, -- The Earthfury
                        16854,16856,16853,16857,16860,16858,16855,16859, -- Lawbringer Armor
                        16866,16868,16865,16861,16863,16864,16867,16862, -- Battlegear of Might
                    },
                    ["Tier 2 Raid Set"] = {
                        16914,16917,16916,16918,16913,16818,16915,16912, -- Netherwind Regalia
                        16921,16924,16923,16926,16920,16925,16922,16919, -- Vestments of Transcendence
                        16929,16932,16931,16934,16928,16933,16930,16927, -- Nemesis Raiment
                        16908,16832,16905,16911,16907,16910,16909,16906, -- Bloodfang Armor
                        16900,16902,16897,16904,16899,16903,16901,16898, -- Stormrage Raiment
                        16939,16937,16942,16935,16940,16936,16938,16941, -- Dragonstalker Armor
                        16947,16945,16950,16943,16948,16944,16946,16949, -- The Ten Storms
                        16955,16953,16958,16951,16956,16952,16954,16957, -- Judgement Armor
                        16963,16961,16966,16959,16964,16960,16962,16965, -- Battlegear of Wrath
                    },
                    ["Tier 3 Raid Set"] = {
                        22490,22491,22488,22495,22493,22494,22489,22492,23064, -- Dreamwalker Raiment
                        22418,22419,22416,22423,22421,22422,22417,22420,23059, -- Dreadnaught's Battlegear
                        22478,22479,22476,22483,22481,22482,22477,22480,23060, -- Bonescythe Armor
                        22514,22515,22512,22519,22517,22518,22513,22516,23061, -- Vestments of Faith
                        22498,22499,22496,22503,22501,22502,22497,22500,23062, -- Frostfire Regalia
                        22466,22467,22464,22471,22469,22470,22465,22468,23065, -- The Earthshatterer
                        22428,22429,22425,22424,22426,22431,22427,22430,23066, -- Redemption Armor
                        22506,22507,22504,22511,22509,22510,22505,22508,23063, -- Plagueheart Raiment
                        22438,22439,22436,22443,22441,22442,22437,22440,23067, -- Cryptstalker Armor
                    },
                },
            },
            ["PVP"] = {
                ["Honor"] = {
                    ["Level 60 PVP Rare Set (Old)"] = {
                        16514,16516,16513,16510,16515,16509, -- Champion's Battlegear
                        16429,16432,16430,16406,16431,16405, -- Lieutenant Commander's Battlegear
                        16521,16524,16522,16519,16523,16518, -- Champion's Earthshaker
                        16489,16492,16491,16487,16490,16485, -- Champion's Regalia
                        17610,17613,17612,17617,17611,17616, -- Champion's Raiment
                        16416,16415,16413,16391,16414,16369, -- Lieutenant Commander's Regalia
                        17598,17601,17600,17596,17599,17594, -- Lieutenant Commander's Raiment
                        17570,17573,17572,17577,17571,17576, -- Champion's Threads
                        17566,17569,17568,17564,17567,17562, -- Lieutenant Commander's Threads
                        16506,16507,16505,16499,16508,16498, -- Champion's Vestments
                        16418,16420,16417,16396,16419,16392, -- Lieutenant Commander's Vestments
                        16526,16528,16525,16530,16527,16531, -- Champion's Pursuit
                        16428,16427,16425,16403,16426,16401, -- Lieutenant Commander's Pursuit
                        16424,16423,16421,16397,16422,16393, -- Lieutenant Commander's Sanctuary
                        16503,16501,16504,16496,16502,16494, -- Champion's Sanctuary
                        16434,16436,16433,16410,16435,16409, -- Lieutenant Commander's Aegis
                    },
                    ["Level 60 PVP Rare Set"] = {
                        23244,23243,22872,22868,22873,22858, -- Champion's Battlearmor
                        23259,23260,22876,22867,22887,22857, -- Champion's Stormcaller
                        23253,23254,22877,22863,22878,22852, -- Champion's Refuge
                        23261,23262,22885,22869,22882,22859, -- Champion's Investiture
                        23255,23256,22884,22865,22881,22855, -- Champion's Dreadgear
                        23263,23264,22886,22870,22883,22860, -- Champion's Arcanum
                        23251,23252,22874,22862,22875,22843, -- Champion's Pursuance
                        23276,23277,23272,23274,23273,23275, -- Lieutenant Commander's Redoubt
                        23314,23315,23300,23286,23301,23287, -- Lieutenant Commander's Battlearmor
                        23318,23319,23305,23290,23304,23291, -- Lieutenant Commander's Arcanum
                        23310,23311,23297,23282,23296,23283, -- Lieutenant Commander's Dreadgear
                        23312,23313,23298,23284,23299,23285, -- Lieutenant Commander's Guard
                        23316,23317,23303,23288,23302,23289, -- Lieutenant Commander's Investiture
                        23306,23307,23292,23279,23293,23278, -- Lieutenant Commander's Pursuance
                        23308,23309,23294,23280,23295,23281, -- Lieutenant Commander's Refuge
                    },
                    ["Level 60 PVP Epic Set"] = {
                        16542,16544,16541,16548,16543,16545, -- Warlord's Battlegear
                        16478,16480,16477,16484,16479,16483, -- Field Marshal's Battlegear
                        16578,16580,16577,16574,16579,16573, -- Warlord's Earthshaker
                        16533,16536,16535,16540,16534,16539, -- Warlord's Regalia
                        16441,16444,16443,16440,16442,16437, -- Field Marshal's Regalia
                        17602,17604,17605,17608,17603,17607, -- Field Marshal's Raiment
                        17623,17622,17624,17620,17625,17618, -- Warlord's Raiment
                        17591,17590,17592,17588,17593,17586, -- Warlord's Threads
                        17578,17580,17581,17584,17579,17583, -- Field Marshal's Threads
                        16561,16562,16563,16560,16564,16558, -- Warlord's Vestments
                        16455,16457,16453,16454,16456,16446, -- Field Marshal's Vestments
                        16465,16468,16466,16463,16467,16462, -- Field Marshal's Pursuit
                        16566,16568,16565,16571,16567,16569, -- Warlord's Pursuit
                        16451,16449,16452,16448,16450,16459, -- Field Marshal's Sanctuary
                        16550,16551,16549,16555,16552,16554, -- Warlord's Sanctuary
                        16474,16476,16473,16471,16475,16472, -- Field Marshal's Aegis
                    },
                },
            }
        }
    }
end

if level >= 1 then -- The Burning Crusade
    db.TBC = {
        ["Armor"] = {
            ["PVE"] = {
                ["Tier"] = {
                    ["Tier 4 Raid Set"] = {
                        29044,29047,29045,29048,29046, -- Netherblade
                        29061,29064,29062,29065,29063, -- Justicar Raiment
                        29068,29070,29066,29067,29069, -- Justicar Armor
                        29073,29075,29071,29072,29074, -- Justicar Battlegear
                        29028,29031,29029,29032,29030, -- Cyclone Raiment
                        29035,29037,29033,29034,29036, -- Cyclone Regalia
                        29040,29043,29038,29039,29042, -- Cyclone Harness
                        29086,29089,29087,29090,29088, -- Malorne Raiment
                        29093,29095,29091,29092,29094, -- Malorne Regalia
                        29098,29100,29096,29097,29099, -- Malorne Harness
                        28963,28967,28964,28968,28966, -- Voidheart Raiment
                        29076,29079,29077,29080,29078, -- Aldor Regalia
                        29081,29084,29082,29085,29083, -- Demon Stalker Armor
                        29011,29016,29012,29017,29015, -- Warbringer Armor
                        29021,29023,29019,29020,29022, -- Warbringer Battlegear
                        29049,29054,29050,29055,29053, -- Incarnate Raiment
                        29058,29060,29056,29057,29059, -- Incarnate Regalia
                    },
                    ["Tier 5 Raid Set"] = {
                        30146,30149,30144,30145,30148, -- Deathmantle
                        30136,30138,30134,30135,30137, -- Crystalforge Raiment
                        30125,30127,30123,30124,30126, -- Crystalforge Armor
                        30131,30133,30129,30130,30132, -- Crystalforge Battlegear
                        30166,30168,30164,30165,30167, -- Cataclysm Raiment
                        30171,30173,30169,30170,30172, -- Cataclysm Regalia
                        30190,30194,30185,30189,30192, -- Cataclysm Harness
                        30228,30230,30222,30223,30229, -- Nordrassil Harness
                        30219,30221,30216,30217,30220, -- Nordrassil Raiment
                        30233,30235,30231,30232,30234, -- Nordrassil Regalia
                        30212,30215,30214,30211,30213, -- Corruptor Raiment
                        30206,30210,30196,30205,30207, -- Tirisfal Regalia
                        30141,30143,30139,30140,30142, -- Rift Stalker Armor
                        30115,30117,30113,30114,30116, -- Destroyer Armor
                        30120,30122,30118,30119,30121, -- Destroyer Battlegear
                        30152,30154,30150,30151,30153, -- Avatar Raiment
                        30161,30163,30159,30160,30162, -- Avatar Regalia
                    },
                    ["Tier 6 Raid Set"] = {
                        31027,31030,31028,34448,31026,34558,31029,34575, -- Slayer's Armor
                        31003,31006,31004,34443,31001,34549,31005,34570, -- Gronnstalker's Armor
                        31051,31054,31052,34436,31050,34541,31053,34564, -- Malefic Raiment
                        31056,31059,31057,34447,31055,34557,31058,34574, -- Tempest Regalia
                        30972,30979,30975,34441,30969,34546,30977,34569, -- Onslaught Battlegear
                        30974,30980,30976,34442,30970,34547,30978,34568, -- Onslaught Armor
                        31064,31070,31065,34434,31061,34528,31067,34563, -- Absolution Regalia
                        31063,31069,31066,34435,31060,34527,31068,34562, -- Vestments of Absolution
                        31039,31048,31042,34444,31034,34556,31044,34573, -- Thunderheart Harness
                        31040,31049,31043,34446,31035,34555,31046,34572, -- Thunderheart Regalia
                        31037,31047,31041,34445,31032,34554,31045,34571, -- Thunderheart Raiment
                        30987,30998,30991,34433,30985,34488,30995,34560, -- Lightbringer Armor
                        30989,30997,30990,34431,30982,34485,30993,34561, -- Lightbringer Battlegear
                        30988,30996,30992,34432,30983,34487,30994,34559, -- Lightbringer Raiment
                        31015,31024,31018,34439,31011,34545,31021,34567, -- Skyshatter Harness
                        31012,31022,31016,34438,31007,34543,31019,34565, -- Skyshatter Raiment
                        31014,31023,31017,34437,31008,34542,31020,34566, -- Skyshatter Regalia
                    },
                },
            },
            ["PVP"] = {
                ["Honor"] = {
                    ["Level 70 PVP Rare Set"] = {
                        28833,28835,28831,28832,28834, -- High Warlord's Aegis
                        28853,28855,28851,28852,28854, -- High Warlord's Battlegear
                        28681,28683,28679,28680,28724, -- Grand Marshal's Aegis
                        28701,28703,28699,28700,28702, -- Grand Marshal's Battlegear
                        28625,28627,28628,28624,28626, -- Grand Marshal's Dreadgear
                        28818,28820,28821,28817,28819, -- High Warlord's Dreadgear
                        28691,28693,28689,28690,28692, -- Grand Marshal's Earthshaker
                        28843,28845,28841,28842,28844, -- High Warlord's Earthshaker
                        28615,28617,28613,28614,28616, -- Grand Marshal's Pursuit
                        28807,28809,28805,28806,28808, -- High Warlord's Pursuit
                        28705,28707,28708,28704,28706, -- Grand Marshal's Raiment
                        28857,28859,28860,28856,28858, -- High Warlord's Raiment
                        28715,28714,28717,28716,28718, -- Grand Marshal's Regalia
                        28867,28866,28869,28868,28870, -- High Warlord's Regalia
                        28619,28622,28623,28618,28620, -- Grand Marshal's Sanctuary
                        28812,28814,28815,28811,28813, -- High Warlord's Sanctuary
                        28696,28698,28694,28695,28697, -- Grand Marshal's Thunderfist
                        28848,28850,28846,28847,28849, -- High Warlord's Thunderfist
                        28685,28687,28688,28684,28686, -- Grand Marshal's Vestments
                        28837,28839,28840,28836,28838, -- High Warlord's Vestments
                        28711,28713,28709,28710,28712, -- Grand Marshal's Vindication
                        28863,28865,28861,28862,28864, -- High Warlord's Vindication
                        28720,28722,28723,28719,28721, -- Grand Marshal's Wildhide
                        28872,28874,28875,28871,28873, -- High Warlord's Wildhide
                    },
                    ["Level 70 PVP Rare Set 2"] = {
                        35329,35331,35332,35328,35330, -- Dreadweave Battlegear
                        35333,35336,35337,35335,35334, -- Mooncloth Battlegear
                        35339,35341,35342,35338,35340, -- Satin Battlegear
                        35344,35343,35346,35345,35347, -- Evoker's Silk Battlegear
                        35357,35359,35360,35356,35358, -- Dragonhide Battlegear
                        35372,35374,35375,35371,35373, -- Wyrmhide Battlegear
                        35362,35364,35365,35361,35363, -- Kodohide Battlegear
                        35367,35369,35370,35366,35368, -- Opportunist's Battlegear
                        35388,35390,35386,35387,35389, -- Seer's Mail Battlegear
                        35393,35395,35391,35392,35394, -- Seer's Ringmail Battlegear
                        35383,35385,35381,35382,35384, -- Seer's Linked Battlegear
                        35378,35380,35376,35377,35379, -- Stalker's Chain Battlegear
                        35409,35411,35407,35408,35410, -- Savage Plate Battlegear
                        35404,35406,35402,35403,35405, -- Crusader's Ornamented Battlegear
                        35414,35416,35412,35413,35415, -- Crusader's Scaled Battlegear
                    },
                    ["Arena Season 1"] = {
                        28244,28245,                   -- General's Amulets
                        28246,28247,                   -- General's Rings
                        28381,28411,28424,28448,28451, -- General's Bracers
                        28605,28638,28643,32973,28445, -- General's Bracers
                        28646,31598,32983,32991,28405, -- General's Bracers
                        28423,28385,32982,28443,28639, -- General's Belts
                        28404,28446,28450,31594,32992, -- General's Belts
                        28629,32974,28409,28641,28644, -- General's Belts
                        28422,28449,32975,28410,32993, -- General's Boots
                        28444,28447,28645,32984,28383, -- General's Boots
                        28402,28630,28640,28642,31595, -- General's Boots
                    },
                    ["Arena Season 2"] = {
                        33068,33065,33066,33067,       -- Veteran's Amulets
                        33056,33057,33064,             -- Veteran's Rings
                        32812,32811,32809,32816,32820, -- Veteran's Bracers
                        32821,32814,32997,32813,32817, -- Veteran's Bracers
                        32989,32980,32810,32818,32819, -- Veteran's Bracers
                        32797,32800,32979,32798,32801, -- Veteran's Belts
                        32803,32808,32807,32988,32998, -- Veteran's Belts
                        32804,32805,32806,32799,32802, -- Veteran's Belts
                        32786,32990,32791,32789,32796, -- Veteran's Boots
                        32981,32999,32785,32790,32792, -- Veteran's Boots
                        32788,32793,32794,32795,32787, -- Veteran's Boots
                    },
                    ["Arena Season 3"] = {
                        33922,33921,35317,35319,33920, -- Vindicator's Amulets
                        33923,                         -- Vindicator's Amulets
                        33919,33853,35320,33918,       -- Vindicator's Rings
                        33881,33813,33893,33917,33876, -- Vindicator's Bracers
                        33897,33887,33889,33894,33901, -- Vindicator's Bracers
                        33904,33906,33913,33883,33910, -- Vindicator's Bracers
                        33811,33885,33877,33888,33891, -- Vindicator's Belts
                        33898,33900,33909,33895,33907, -- Vindicator's Belts
                        33879,33882,33903,33912,33915, -- Vindicator's Belts
                        33902,33880,33812,33905,33911, -- Vindicator's Boots
                        33914,33916,33890,33886,33884, -- Vindicator's Boots
                        33892,33896,33899,33908,33878, -- Vindicator's Boots
                    },
                    ["Arena Season 4"] = {
                        35133,37928,35134,35135,37929, -- Guardian's Amulets
                        35132,                         -- Guardian's Amulets
                        44429,44431,41592,41591,       -- Guardian's Cloaks
                        35129,35131,37927,35130,       -- Guardian's Rings
                        35168,35174,35179,35177,35167, -- Guardian's Bracers
                        35176,35178,35166,35169,35170, -- Guardian's Bracers
                        35171,35172,35173,35175,35180, -- Guardian's Bracers
                        35164,35156,35162,35159,35153, -- Guardian's Belts
                        35154,35155,35157,35161,35163, -- Guardian's Belts
                        35165,35151,35152,35158,35160, -- Guardian's Belts
                        35140,35144,35142,35137,35138, -- Guardian's Boots
                        35136,35146,35148,35149,35141, -- Guardian's Boots
                        35143,35147,35139,35145,35150, -- Guardian's Boots
                    },
                },
                ["Arena"] = {
                    ["Arena Season 1"] = {
                        25830,25832,25831,25834,25833, -- Gladiator's Vestments
                        25998,25999,25997,26000,26001, -- Gladiator's Earthshaker
                        25855,25854,25856,25857,25858, -- Gladiator's Regalia
                        27471,27473,27469,27470,27472, -- Gladiator's Thunderfist
                        27708,27710,27711,27707,27709, -- Gladiator's Raiment
                        27704,27706,27702,27703,27705, -- Gladiator's Aegis
                        27881,27883,27879,27880,27882, -- Gladiator's Vindication
                        28127,28129,28130,28126,28128, -- Gladiator's Sanctuary
                        28137,28139,28140,28136,28138, -- Gladiator's Wildhide
                        28331,28333,28334,28335,28332, -- Gladiator's Pursuit
                        30187,30186,30200,30188,30201, -- Gladiator's Felshroud
                    },
                    ["Arena Season 2"] = {
                        31997,31996,31992,31993,31995, -- Merciless Gladiator's Aegis
                        30488,30490,30486,30487,30489, -- Merciless Gladiator's Battlegear
                        31974,31976,31977,31973,31975, -- Merciless Gladiator's Dreadgear
                        32006,32008,32004,32005,32007, -- Merciless Gladiator's Earthshaker
                        31980,31979,31982,31981,31983, -- Merciless Gladiator's Felshroud
                        32016,32018,32019,32015,32017, -- Merciless Gladiator's Investiture
                        31962,31964,31960,31961,31963, -- Merciless Gladiator's Pursuit
                        32035,32037,32038,32034,32036, -- Merciless Gladiator's Raiment
                        32022,32024,32020,32021,32023, -- Merciless Gladiator's Redemption
                        31988,31990,31991,31987,31989, -- Merciless Gladiator's Refuge
                        32048,32047,32050,32049,32051, -- Merciless Gladiator's Regalia
                        31968,31971,31972,31967,31969, -- Merciless Gladiator's Sanctuary
                        32011,32013,32009,32010,32012, -- Merciless Gladiator's Thunderfist
                        31999,32001,32002,31998,32000, -- Merciless Gladiator's Vestments
                        32041,32043,32039,32040,32042, -- Merciless Gladiator's Vindication
                        32031,32033,32029,32030,32032, -- Merciless Gladiator's Wartide
                        32057,32059,32060,32056,32058, -- Merciless Gladiator's Wildhide
                    },
                    ["Arena Season 3"] = {
                        33691,33693,33694,33690,33692, -- Vengeful Gladiator's Refuge
                        33672,33674,33675,33671,33673, -- Vengeful Gladiator's Sanctuary
                        33768,33770,33771,33767,33769, -- Vengeful Gladiator's Wildhide
                        33666,33668,33664,33665,33667, -- Vengeful Gladiator's Pursuit
                        33758,33757,33760,33759,33761, -- Vengeful Gladiator's Regalia
                        33724,33726,33722,33723,33725, -- Vengeful Gladiator's Redemption
                        33751,33753,33749,33750,33752, -- Vengeful Gladiator's Vindication
                        33697,33699,33695,33696,33698, -- Vengeful Gladiator's Aegis
                        33718,33720,33721,33717,33719, -- Vengeful Gladiator's Investiture
                        33745,33747,33748,33744,33746, -- Vengeful Gladiator's Raiment
                        33701,33703,33704,33700,33702, -- Vengeful Gladiator's Vestments
                        33740,33742,33738,33739,33741, -- Vengeful Gladiator's Wartide
                        33708,33710,33706,33707,33709, -- Vengeful Gladiator's Earthshaker
                        33713,33715,33711,33712,33714, -- Vengeful Gladiator's Thunderfist
                        33677,33679,33680,33676,33678, -- Vengeful Gladiator's Dreadgear
                        33683,33682,33685,33684,33686, -- Vengeful Gladiator's Felshroud
                        33730,33732,33728,33729,33731, -- Vengeful Gladiator's Battlegear
                    },
                    ["Arena Season 4"] = {
                        35068,35070,35066,35067,35069, -- Brutal Gladiator's Battlegear
                        35004,35006,35007,35003,35005, -- Brutal Gladiator's Dreadgear
                        35033,35035,35036,35032,35034, -- Brutal Gladiator's Vestments
                        35044,35046,35042,35043,35045, -- Brutal Gladiator's Earthshaker
                        35097,35096,35099,35098,35100, -- Brutal Gladiator's Regalia
                        35050,35052,35048,35049,35051, -- Brutal Gladiator's Thunderfist
                        35084,35086,35087,35083,35085, -- Brutal Gladiator's Raiment
                        35029,35031,35027,35028,35030, -- Brutal Gladiator's Aegis
                        35090,35092,35088,35089,35091, -- Brutal Gladiator's Vindication
                        34999,35001,35002,34998,35000, -- Brutal Gladiator's Sanctuary
                        35112,35114,35115,35111,35113, -- Brutal Gladiator's Wildhide
                        34992,34994,34990,34991,34993, -- Brutal Gladiator's Pursuit
                        35010,35009,35012,35011,35013, -- Brutal Gladiator's Felshroud
                        35023,35025,35026,35022,35024, -- Brutal Gladiator's Refuge
                        35079,35081,35077,35078,35080, -- Brutal Gladiator's Wartide
                        35054,35056,35057,35053,35055, -- Brutal Gladiator's Investiture
                        35061,35063,35059,35060,35062, -- Brutal Gladiator's Redemption
                    },
                }
            }
        },
        ["Weapons"] = {
            ["PVE"] = {
                ["Tier"] = {

                }
            },
            ["PVP"] = {
                ["Arena"] = {
                    ["Arena Season 1"] = {
                        28312,32451,28295,28297,28308, -- Gladiator's One-Handed Weapons
                        28309,32450,28302,28310,28314, -- Gladiator's One-Handed Weapons
                        28305,28307,28313,             -- Gladiator's One-Handed Weapons
                        28294,28320,28319,             -- Gladiator's Ranged Weapons and Wands
                        28300,28298,28476,24550,24557, -- Gladiator's Two-Handed Weapons
                        28299,                         -- Gladiator's Two-Handed Weapons
                        28358,28346,32452,             -- Gladiator's Offhands and Shields
                        33936,28356,28357,33939,33945, -- Gladiator's Relics
                        33948,33942,33951,28355,       -- Gladiator's Relics
                    },
                    ["Arena Season 2"] = {
                        32044,32052,32026,32053,32963, -- Merciless Gladiator's One-Handed Weapons
                        32027,31958,31965,32028,32046, -- Merciless Gladiator's One-Handed Weapons
                        31985,32964,32003,             -- Merciless Gladiator's One-Handed Weapons
                        31986,32054,32962,             -- Merciless Gladiator's Ranged Weapons and Wands
                        31966,31984,32014,32055,31959, -- Merciless Gladiator's Two-Handed Weapons
                        32025,                         -- Merciless Gladiator's Two-Handed Weapons
                        32961,33309,33313,32045,31978, -- Merciless Gladiator's Offhands and Shields
                        33946,33949,33078,33077,33940, -- Merciless Gladiator's Relics
                        33943,33952,33076,33937,       -- Merciless Gladiator's Relics
                    },
                    ["Arena Season 3"] = {
                        33734,33662,33669,34016,33689, -- Vengeful Gladiator's One-Handed Weapons
                        33754,33687,33705,33737,33756, -- Vengeful Gladiator's One-Handed Weapons
                        33763,33801,34015,33733,33743, -- Vengeful Gladiator's One-Handed Weapons
                        33762,                         -- Vengeful Gladiator's One-Handed Weapons
                        34529,34530,33006,33765,34059, -- Vengeful Gladiator's Ranged Weapons and Wands
                        34066,33764,                   -- Vengeful Gladiator's Ranged Weapons and Wands
                        33688,33766,34014,33663,33670, -- Vengeful Gladiator's Two-Handed Weapons
                        33727,34540,33716,             -- Vengeful Gladiator's Two-Handed Weapons
                        33755,33661,33735,33681,33736, -- Vengeful Gladiator's Offhands and Shields
                        34033,                         -- Vengeful Gladiator's Offhands and Shields
                        33938,33944,33950,33947,33841, -- Vengeful Gladiator's Relics
                        33842,33843,33941,33953,       -- Vengeful Gladiator's Relics
                    },
                    ["Arena Season 4"] = {
                        35058,35072,34996,35101,37739, -- Brutal Gladiator's One-Handed Weapons
                        34988,35014,34995,35037,35071, -- Brutal Gladiator's One-Handed Weapons
                        35082,35038,35093,36737,37740, -- Brutal Gladiator's One-Handed Weapons
                        35017,35076,35095,35102,35110, -- Brutal Gladiator's One-Handed Weapons
                        35047,35075,35108,34985,35065, -- Brutal Gladiator's Ranged Weapons and Wands
                        35018,35107,                   -- Brutal Gladiator's Ranged Weapons and Wands
                        35015,34997,35103,34987,34989, -- Brutal Gladiator's Two-Handed Weapons
                        35109,35064,                   -- Brutal Gladiator's Two-Handed Weapons
                        35094,34986,35016,35008,35073, -- Brutal Gladiator's Offhands and Shields
                        35074,                         -- Brutal Gladiator's Offhands and Shields
                        35106,35019,35021,35105,35040, -- Brutal Gladiator's Relics
                        35041,35039,35020,35104,       -- Brutal Gladiator's Relics
                    },
                }
            }
        },
    }
end

if level >= 2 then -- Wrath of the Lich King
    db.Wrath = {
        ["Armor"] = {
            ["PVE"] = {
                ["Tier"] = {
                    ["Tier 7 Raid Set"] = {
                        39610,39613,39611,39622,39612, -- Heroes' Dreadnaught Plate
                        39605,39608,39606,39609,39607, -- Heroes' Dreadnaught Battlegear
                        39635,39637,39633,39634,39636, -- Heroes' Redemption Battlegear
                        39628,39631,39629,39632,39630, -- Heroes' Redemption Regalia
                        39640,39642,39638,39639,39641, -- Heroes' Redemption Plate
                        39619,39621,39617,39618,39620, -- Heroes' Scourgeborne Battlegear
                        39625,39627,39623,39624,39626, -- Heroes' Scourgeborne Plate
                        39578,39581,39579,39582,39580, -- Heroes' Cryptstalker Battlegear
                        39602,39604,39597,39601,39603, -- Heroes' Earthshatter Battlegear
                        39594,39596,39592,39593,39595, -- Heroes' Earthshatter Garb
                        39583,39590,39588,39591,39589, -- Heroes' Earthshatter Regalia
                        39553,39556,39554,39557,39555, -- Heroes' Dreamwalker Battlegear
                        39531,39542,39538,39543,39539, -- Heroes' Dreamwalker Regalia
                        39545,39548,39547,39544,39546, -- Heroes' Dreamwalker Garb
                        39561,39565,39558,39560,39564, -- Heroes' Bonescythe Battlegear
                        39496,39499,39497,39500,39498, -- Heroes' Plagueheart Garb
                        39491,39494,39492,39495,39493, -- Heroes' Frostfire Garb
                        39514,39518,39515,39519,39517, -- Heroes' Regalia of Faith
                        39521,39529,39523,39530,39528, -- Heroes' Garb of Faith
                    },
                    ["Tier 7.5 Raid Set"] = {
                        40546,40548,40544,40545,40547, -- Valorous Dreadnaught Plate
                        40528,40530,40525,40527,40529, -- Valorous Dreadnaught Battlegear
                        40576,40578,40574,40575,40577, -- Valorous Redemption Battlegear
                        40571,40573,40569,40570,40572, -- Valorous Redemption Regalia
                        40581,40584,40579,40580,40583, -- Valorous Redemption Plate
                        40554,40557,40550,40552,40556, -- Valorous Scourgeborne Battlegear
                        40565,40568,40559,40563,40567, -- Valorous Scourgeborne Plate
                        40505,40507,40503,40504,40506, -- Valorous Cryptstalker Battlegear
                        40521,40524,40523,40520,40522, -- Valorous Earthshatter Battlegear
                        40516,40518,40514,40515,40517, -- Valorous Earthshatter Garb
                        40510,40513,40508,40509,40512, -- Valorous Earthshatter Regalia
                        40473,40494,40471,40472,40493, -- Valorous Dreamwalker Battlegear
                        40461,40465,40463,40460,40462, -- Valorous Dreamwalker Regalia
                        40467,40470,40469,40466,40468, -- Valorous Dreamwalker Garb
                        40499,40502,40495,40496,40500, -- Valorous Bonescythe Battlegear
                        40421,40424,40423,40420,40422, -- Valorous Plagueheart Garb
                        40416,40419,40418,40415,40417, -- Valorous Frostfire Garb
                        40447,40450,40449,40445,40448, -- Valorous Regalia of Faith
                        40456,40459,40458,40454,40457, -- Valorous Garb of Faith
                    },
                    ["Tier 8 Raid Set"] = {
                        45377,45380,45375,45376,45379, -- Valorous Aegis Battlegear
                        45382,45385,45381,45383,45384, -- Valorous Aegis Plate
                        45372,45373,45374,45370,45371, -- Valorous Aegis Regalia
                        45412,45415,45413,45414,45416, -- Valorous Worldbreaker Battlegear
                        45408,45410,45411,45406,45409, -- Valorous Worldbreaker Garb
                        45402,45404,45405,45401,45403, -- Valorous Worldbreaker Regalia
                        45398,45400,45396,45397,45399, -- Valorous Terrorblade Battlegear
                        45356,45359,45358,45355,45357, -- Valorous Nightsong Battlegear
                        46313,45352,45354,45351,45353, -- Valorous Nightsong Garb
                        45346,45349,45348,45345,45347, -- Valorous Nightsong Regalia
                        45431,45433,45429,45430,45432, -- Valorous Siegebreaker Battlegear
                        45425,45428,45424,45426,45427, -- Valorous Siegebreaker Plate
                        45391,45393,45395,45392,45394, -- Valorous Sanctification Garb
                        45386,45390,45389,45387,45388, -- Valorous Sanctification Regalia
                        45342,45344,45340,45341,45343, -- Valorous Darkruned Battlegear
                        45336,45339,45335,45337,45338, -- Valorous Darkruned Plate
                        45365,45369,45368,46131,45367, -- Valorous Kirin Tor Garb
                        45417,45422,45421,45419,45420, -- Valorous Deathbringer Garb
                        45361,45363,45364,45360,45362, -- Valorous Scourgestalker Battlegear
                    },
                    ["Tier 8.5 Raid Set"] = {
                        46156,46152,46154,46155,46153, -- Conqueror's Aegis Battlegear
                        46175,46177,46173,46174,46176, -- Conqueror's Aegis Plate
                        46180,46182,46178,46179,46181, -- Conqueror's Aegis Regalia
                        46212,46203,46205,46200,46208, -- Conqueror's Worldbreaker Battlegear
                        46209,46211,46206,46207,46210, -- Conqueror's Worldbreaker Garb
                        46201,46204,46198,46199,46202, -- Conqueror's Worldbreaker Regalia
                        46125,46127,46123,46124,46126, -- Conqueror's Terrorblade Battlegear
                        46161,46157,46159,46158,46160, -- Conqueror's Nightsong Battlegear
                        46191,46196,46194,46189,46192, -- Conqueror's Nightsong Garb
                        46184,46187,46186,46183,46185, -- Conqueror's Nightsong Regalia
                        46151,46149,46146,46148,46150, -- Conqueror's Siegebreaker Battlegear
                        46166,46167,46162,46164,46169, -- Conqueror's Siegebreaker Plate
                        46172,46165,46168,46163,46170, -- Conqueror's Sanctification Garb
                        46197,46190,46193,46188,46195, -- Conqueror's Sanctification Regalia
                        46115,46117,46111,46113,46116, -- Conqueror's Darkruned Battlegear
                        46120,46122,46118,46119,46121, -- Conqueror's Darkruned Plate
                        46129,46134,46130,46132,46133, -- Conqueror's Kirin Tor Garb
                        46140,46136,46137,46135,46139, -- Conqueror's Deathbringer Garb
                        46143,46145,46141,46142,46144, -- Conqueror's Scourgestalker Battlegear
                    },
                    ["Tier 9 Raid Set"] = {
                        48726,48729,48728,48725,48727, -- Khadgar's Regalia
                        48731,48734,48733,48730,48732, -- Sunstrider's Regalia
                        48736,48739,48738,48735,48737, -- Gul'dan's Regalia
                        48741,48744,48743,48740,48742, -- Kel'Thuzad's Regalia
                        48745,48749,48748,48746,48747, -- Velen's Raiment
                        48750,48754,48753,48751,48752, -- Zabra's Raiment
                        48755,48757,48759,48756,48758, -- Velen's Regalia
                        48760,48762,48764,48761,48763, -- Zabra's Regalia
                        48775,48778,48777,48774,48776, -- Malfurion's Garb
                        48770,48773,48772,48769,48771, -- Runetotem's Garb
                        48786,48788,48790,48787,48789, -- Malfurion's Regalia
                        48781,48783,48785,48782,48784, -- Runetotem's Regalia
                        48800,48803,48802,48799,48801, -- Malfurion's Battlegear
                        48795,48798,48797,48794,48796, -- Runetotem's Battlegear
                        48811,48813,48809,48810,48812, -- VanCleef's Battlegear
                        48806,48808,48804,48805,48807, -- Garona's Battlegear
                        48820,48822,48823,48819,48821, -- Windrunner's Battlegear
                        48815,48817,48818,48814,48816, -- Windrunner's Pursuit
                        48825,48827,48828,48824,48826, -- Nobundo's Garb
                        48830,48832,48833,48829,48831, -- Thrall's Garb
                        48843,48845,48842,48841,48844, -- Thrall's Regalia
                        48838,48840,48837,48836,48839, -- Nobundo's Regalia
                        48847,48849,48846,48848,48850, -- Nobundo's Battlegear
                        48852,48854,48851,48853,48855, -- Thrall's Battlegear
                        48867,48869,48865,48866,48868, -- Wrynn's Battlegear
                        48862,48864,48860,48861,48863, -- Hellscream's Battlegear
                        48876,48879,48875,48877,48878, -- Wrynn's Plate
                        48871,48874,48870,48872,48873, -- Hellscream's Plate
                        48887,48889,48885,48886,48888, -- Thassarian's Battlegear
                        48882,48884,48880,48881,48883, -- Koltira's Battlegear
                        48896,48899,48895,48897,48898, -- Thassarian's Plate
                        48891,48894,48890,48892,48893, -- Koltira's Plate
                        48902,48901,48900,48904,48903, -- Turalyon's Garb
                        48907,48906,48905,48909,48908, -- Liadrin's Garb
                        48917,48919,48915,48916,48918, -- Turalyon's Battlegear
                        48912,48914,48910,48911,48913, -- Liadrin's Battlegear
                        48928,48931,48927,48929,48930, -- Turalyon's Plate
                        48923,48926,48922,48924,48925, -- Liadrin's Plate
                    },
                    ["Tier 9.25 Raid Set"] = {
                        47754,47757,47756,47753,47755, -- Triumphant Khadgar's Regalia
                        47771,47768,47769,47772,47770, -- Triumphant Sunstrider's Regalia
                        47804,47807,47806,47803,47805, -- Triumphant Gul'dan's Regalia
                        47778,47781,47779,47782,47780, -- Triumphant Kel'Thuzad's Regalia
                        47984,47987,47986,47983,47985, -- Triumphant Velen's Raiment
                        48065,48062,48063,48066,48064, -- Triumphant Zabra's Raiment
                        48078,48081,48080,48077,48079, -- Triumphant Velen's Regalia
                        48095,48092,48093,48096,48094, -- Triumphant Zabra's Regalia
                        48134,48137,48136,48133,48135, -- Triumphant Malfurion's Garb
                        48151,48148,48149,48152,48150, -- Triumphant Runetotem's Garb
                        48164,48167,48166,48163,48165, -- Triumphant Malfurion's Regalia
                        48181,48178,48179,48182,48180, -- Triumphant Runetotem's Regalia
                        48211,48208,48209,48212,48210, -- Triumphant Malfurion's Battlegear
                        48194,48197,48196,48193,48195, -- Triumphant Runetotem's Battlegear
                        48225,48227,48223,48224,48226, -- Triumphant VanCleef's Battlegear
                        48240,48238,48242,48241,48239, -- Triumphant Garona's Battlegear
                        48257,48259,48255,48256,48258, -- Triumphant Windrunner's Battlegear
                        48272,48270,48274,48273,48271, -- Triumphant Windrunner's Pursuit
                        48287,48289,48285,48286,48288, -- Triumphant Nobundo's Garb
                        48302,48304,48300,48301,48303, -- Triumphant Thrall's Garb
                        48333,48331,48335,48334,48332, -- Triumphant Thrall's Regalia
                        48318,48320,48316,48317,48319, -- Triumphant Nobundo's Regalia
                        48348,48350,48346,48347,48349, -- Triumphant Nobundo's Battlegear
                        48363,48361,48365,48364,48362, -- Triumphant Thrall's Battlegear
                        48378,48380,48376,48377,48379, -- Triumphant Wrynn's Battlegear
                        48393,48395,48391,48392,48394, -- Triumphant Hellscream's Battlegear
                        48430,48454,48450,48452,48446, -- Triumphant Wrynn's Plate
                        48463,48465,48461,48462,48464, -- Triumphant Hellscream's Plate
                        48483,48485,48481,48482,48484, -- Triumphant Thassarian's Battlegear
                        48498,48496,48500,48499,48497, -- Triumphant Koltira's Battlegear
                        48540,48542,48538,48539,48541, -- Triumphant Thassarian's Plate
                        48555,48553,48557,48556,48554, -- Triumphant Koltira's Plate
                        48577,48579,48575,48576,48578, -- Triumphant Turalyon's Garb
                        48592,48590,48594,48593,48591, -- Triumphant Liadrin's Garb
                        48609,48611,48607,48608,48610, -- Triumphant Turalyon's Battlegear
                        48624,48622,48626,48625,48623, -- Triumphant Liadrin's Battlegear
                        48639,48637,48641,48640,48638, -- Triumphant Turalyon's Plate
                        48659,48661,48657,48658,48660, -- Triumphant Liadrin's Plate
                    },
                    ["Tier 9.5 Raid Set"] = {
                        47761,47758,47759,47762,47760, -- Triumphant Khadgar's Regalia
                        47764,47767,47766,47763,47765, -- Triumphant Sunstrider's Regalia
                        47796,47793,47794,47797,47795, -- Triumphant Gul'dan's Regalia
                        47789,47792,47791,47788,47790, -- Triumphant Kel'Thuzad's Regalia
                        48035,48029,48031,48037,48033, -- Triumphant Velen's Raiment
                        48058,48061,48060,48057,48059, -- Triumphant Zabra's Raiment
                        48085,48082,48083,48086,48084, -- Triumphant Velen's Regalia
                        48088,48091,48090,48087,48089, -- Triumphant Zabra's Regalia
                        48141,48138,48139,48142,48140, -- Triumphant Malfurion's Garb
                        48144,48147,48146,48143,48145, -- Triumphant Runetotem's Garb
                        48171,48168,48169,48172,48170, -- Triumphant Malfurion's Regalia
                        48174,48177,48176,48173,48175, -- Triumphant Runetotem's Regalia
                        48204,48207,48206,48203,48205, -- Triumphant Malfurion's Battlegear
                        48201,48198,48199,48202,48200, -- Triumphant Runetotem's Battlegear
                        48230,48228,48232,48231,48229, -- Triumphant VanCleef's Battlegear
                        48235,48237,48233,48234,48236, -- Triumphant Garona's Battlegear
                        48262,48260,48264,48263,48261, -- Triumphant Windrunner's Battlegear
                        48267,48269,48265,48266,48268, -- Triumphant Windrunner's Pursuit
                        48292,48290,48294,48293,48291, -- Triumphant Nobundo's Garb
                        48307,48309,48305,48306,48308, -- Triumphant Thrall's Garb
                        48328,48330,48326,48327,48329, -- Triumphant Thrall's Regalia
                        48323,48321,48325,48324,48322, -- Triumphant Nobundo's Regalia
                        48353,48351,48355,48354,48352, -- Triumphant Nobundo's Battlegear
                        48358,48360,48356,48357,48359, -- Triumphant Thrall's Battlegear
                        48383,48381,48385,48384,48382, -- Triumphant Wrynn's Battlegear
                        48398,48400,48396,48397,48399, -- Triumphant Hellscream's Battlegear
                        48433,48455,48451,48453,48447, -- Triumphant Wrynn's Plate
                        48468,48470,48466,48467,48469, -- Triumphant Hellscream's Plate
                        48488,48486,48490,48489,48487, -- Triumphant Thassarian's Battlegear
                        48493,48495,48491,48492,48494, -- Triumphant Koltira's Battlegear
                        48545,48543,48547,48546,48544, -- Triumphant Thassarian's Plate
                        48550,48552,48548,48549,48551, -- Triumphant Koltira's Plate
                        48582,48580,48584,48583,48581, -- Triumphant Turalyon's Garb
                        48587,48585,48589,48588,48586, -- Triumphant Liadrin's Garb
                        48614,48612,48616,48615,48613, -- Triumphant Turalyon's Battlegear
                        48619,48621,48617,48618,48620, -- Triumphant Liadrin's Battlegear
                        48644,48646,48642,48643,48645, -- Triumphant Turalyon's Plate
                        48649,48647,48651,48650,48648, -- Triumphant Liadrin's Plate
                    },
                    ["Tier 10 Raid Set"] = {
                        51715,51712,51713,51716,51714, -- Bloodmage's Regalia
                        51765,51762,51763,51766,51764, -- Dark Coven's Regalia
                        51736,51734,51733,51735,51732, -- Crimson Acolyte's Raiment
                        51737,51739,51740,51738,51741, -- Crimson Acolyte's Regalia
                        51694,51692,51696,51695,51693, -- Lasherweave Garb
                        51704,51706,51702,51703,51705, -- Lasherweave Regalia
                        51699,51701,51697,51698,51700, -- Lasherweave Battlegear
                        51745,51746,51743,51742,51744, -- Shadowblade's Battlegear
                        51710,51708,51707,51711,51709, -- Ahn'Kahar Blood Hunter's Battlegear
                        51749,51751,51747,51748,51750, -- Frost Witch's Garb
                        51759,51761,51757,51758,51760, -- Frost Witch's Regalia
                        51754,51756,51752,51753,51755, -- Frost Witch's Battlegear
                        51769,51767,51771,51770,51768, -- Ymirjar Lord's Battlegear
                        51774,51776,51772,51773,51775, -- Ymirjar Lord's Plate
                        51684,51682,51686,51685,51683, -- Scourgelord's Battlegear
                        51689,51691,51687,51688,51690, -- Scourgelord's Plate
                        51724,51726,51722,51723,51725, -- Lightsworn Garb
                        51719,51721,51717,51718,51720, -- Lightsworn Battlegear
                        51729,51731,51727,51728,51730, -- Lightsworn Plate
                    },
                    ["Tier 10.25 Raid Set"] = {
                        51158,51155,51156,51159,51157, -- Sanctified Bloodmage's Regalia
                        51208,51205,51206,51209,51207, -- Sanctified Dark Coven's Regalia
                        51178,51175,51176,51179,51177, -- Sanctified Crimson Acolyte's Raiment
                        51184,51182,51180,51183,51181, -- Sanctified Crimson Acolyte's Regalia
                        51137,51135,51139,51138,51136, -- Sanctified Lasherweave Garb
                        51149,51147,51145,51148,51146, -- Sanctified Lasherweave Regalia
                        51143,51140,51141,51144,51142, -- Sanctified Lasherweave Battlegear
                        51187,51185,51189,51188,51186, -- Sanctified Shadowblade's Battlegear
                        51153,51151,51150,51154,51152, -- Sanctified Ahn'Kahar Blood Hunter's Battlegear
                        51192,51194,51190,51191,51193, -- Sanctified Frost Witch's Garb
                        51202,51204,51200,51201,51203, -- Sanctified Frost Witch's Regalia
                        51197,51199,51195,51196,51198, -- Sanctified Frost Witch's Battlegear
                        51212,51210,51214,51213,51211, -- Sanctified Ymirjar Lord's Battlegear
                        51218,51215,51219,51217,51216, -- Sanctified Ymirjar Lord's Plate
                        51127,51125,51129,51128,51126, -- Sanctified Scourgelord's Battlegear
                        51133,51130,51134,51132,51131, -- Sanctified Scourgelord's Plate
                        51167,51166,51165,51169,51168, -- Sanctified Lightsworn Garb
                        51162,51160,51164,51163,51161, -- Sanctified Lightsworn Battlegear
                        51173,51170,51174,51172,51171, -- Sanctified Lightsworn Plate
                    },
                    ["Tier 10.5 Raid Set"] = {
                        51281,51284,51283,51280,51282, -- Heroic Sanctified Bloodmage's Regalia
                        51231,51234,51233,51230,51232, -- Heroic Sanctified Dark Coven's Regalia
                        51261,51264,51263,51260,51262, -- Heroic Sanctified Crimson Acolyte's Raiment
                        51255,51257,51259,51256,51258, -- Heroic Sanctified Crimson Acolyte's Regalia
                        51302,51304,51300,51301,51303, -- Heroic Sanctified Lasherweave Garb
                        51290,51292,51294,51291,51293, -- Heroic Sanctified Lasherweave Regalia
                        51296,51299,51298,51295,51297, -- Heroic Sanctified Lasherweave Battlegear
                        51252,51254,51250,51251,51253, -- Heroic Sanctified Shadowblade's Battlegear
                        51286,51288,51289,51285,51287, -- Heroic Sanctified Ahn'Kahar Blood Hunter's Battlegear
                        51247,51245,51249,51248,51246, -- Heroic Sanctified Frost Witch's Garb
                        51237,51235,51239,51238,51236, -- Heroic Sanctified Frost Witch's Regalia
                        51242,51240,51244,51243,51241, -- Heroic Sanctified Frost Witch's Battlegear
                        51227,51229,51225,51226,51228, -- Heroic Sanctified Ymirjar Lord's Battlegear
                        51221,51224,51220,51222,51223, -- Heroic Sanctified Ymirjar Lord's Plate
                        51312,51314,51310,51311,51313, -- Heroic Sanctified Scourgelord's Battlegear
                        51306,51309,51305,51307,51308, -- Heroic Sanctified Scourgelord's Plate
                        51272,51273,51274,51270,51271, -- Heroic Sanctified Lightsworn Garb
                        51277,51279,51275,51276,51278, -- Heroic Sanctified Lightsworn Battlegear
                        51266,51269,51265,51267,51268, -- Heroic Sanctified Lightsworn Plate
                    },
                },
            },
            ["PVP"] = {
                ["Arena"] = {
                    ["Arena Season 5 Savage"] = { -- (200)
                        40816,40856,40778,40797,40836, -- Savage Gladiator's Battlegear
                        40818,40858,40780,40798,40838, -- Savage Gladiator's Vindication
                        40930,40960,40898,40918,40936, -- Savage Gladiator's Redemption
                        40817,40857,40779,40799,40837, -- Savage Gladiator's Desecration
                        41016,41041,40987,41004,41030, -- Savage Gladiator's Thunderfist
                        41148,41208,41078,41134,41160, -- Savage Gladiator's Earthshaker
                        41010,41024,40986,40998,41023, -- Savage Gladiator's Wartide
                        41154,41214,41084,41140,41202, -- Savage Gladiator's Pursuit
                        41269,41271,41272,41268,41270, -- Savage Gladiator's Refuge
                        41324,41278,41313,41290,41301, -- Savage Gladiator's Wildhide
                        41675,41712,41658,41770,41664, -- Savage Gladiator's Sanctuary
                        41644,41646,41647,41643,41645, -- Savage Gladiator's Vestments
                        41848,41850,41851,41847,41849, -- Savage Gladiator's Investiture
                        41912,41930,41918,41937,41924, -- Savage Gladiator's Raiment
                        41943,41962,41949,41968,41956, -- Savage Gladiator's Regalia
                        41990,42008,41996,42014,42002, -- Savage Gladiator's Felshroud
                    },
                    ["Arena Season 5 Hateful"] = { -- (200)
                        40819,40859,40783,40801,40840, -- Hateful Gladiator's Battlegear
                        40821,40861,40782,40802,40842, -- Hateful Gladiator's Vindication
                        40931,40961,40904,40925,40937, -- Hateful Gladiator's Redemption
                        40820,40860,40781,40803,40841, -- Hateful Gladiator's Desecration
                        41017,41042,40989,41005,41031, -- Hateful Gladiator's Thunderfist
                        41149,41209,41079,41135,41162, -- Hateful Gladiator's Earthshaker
                        41011,41036,40988,40999,41025, -- Hateful Gladiator's Wartide
                        41155,41215,41085,41141,41203, -- Hateful Gladiator's Pursuit
                        41319,41273,41308,41284,41296, -- Hateful Gladiator's Refuge
                        41325,41279,41314,41291,41302, -- Hateful Gladiator's Wildhide
                        41676,41713,41659,41771,41665, -- Hateful Gladiator's Sanctuary
                        41670,41681,41648,41765,41653, -- Hateful Gladiator's Vestments
                        41852,41867,41857,41872,41862, -- Hateful Gladiator's Investiture
                        41913,41931,41919,41938,41925, -- Hateful Gladiator's Raiment
                        41944,41963,41950,41969,41957, -- Hateful Gladiator's Regalia
                        41991,42009,42001,42015,42003, -- Hateful Gladiator's Felshroud
                    },
                    ["Arena Season 5 Deadly"] = { -- (213)
                        40823,40862,40786,40804,40844, -- Deadly Gladiator's Battlegear
                        40825,40864,40785,40805,40846, -- Deadly Gladiator's Vindication
                        40932,40962,40905,40926,40938, -- Deadly Gladiator's Redemption
                        40824,40863,40784,40806,40845, -- Deadly Gladiator's Desecration
                        41018,41043,40991,41006,41032, -- Deadly Gladiator's Thunderfist
                        41150,41210,41080,41136,41198, -- Deadly Gladiator's Earthshaker
                        41012,41037,40990,41000,41026, -- Deadly Gladiator's Wartide
                        41156,41216,41086,41142,41204, -- Deadly Gladiator's Pursuit
                        41320,41274,41309,41286,41297, -- Deadly Gladiator's Refuge
                        41326,41280,41315,41292,41303, -- Deadly Gladiator's Wildhide
                        41677,41714,41660,41772,41666, -- Deadly Gladiator's Sanctuary
                        41671,41682,41649,41766,41654, -- Deadly Gladiator's Vestments
                        41853,41868,41858,41873,41863, -- Deadly Gladiator's Investiture
                        41914,41933,41920,41939,41926, -- Deadly Gladiator's Raiment
                        41945,41964,41951,41970,41958, -- Deadly Gladiator's Regalia
                        41992,42010,41997,42016,42004, -- Deadly Gladiator's Felshroud
                    },
                    ["Arena Season 6"] = { -- 232
                        40826,40866,40789,40807,40847, -- Furious Gladiator's Battlegear
                        40828,40869,40788,40808,40849, -- Furious Gladiator's Vindication
                        40933,40963,40907,40927,40939, -- Furious Gladiator's Redemption
                        40827,40868,40787,40809,40848, -- Furious Gladiator's Desecration
                        41019,41044,40993,41007,41033, -- Furious Gladiator's Thunderfist
                        41151,41211,41081,41137,41199, -- Furious Gladiator's Earthshaker
                        41013,41038,40992,41001,41027, -- Furious Gladiator's Wartide
                        41157,41217,41087,41143,41205, -- Furious Gladiator's Pursuit
                        41321,41275,41310,41287,41298, -- Furious Gladiator's Refuge
                        41327,41281,41316,41293,41304, -- Furious Gladiator's Wildhide
                        41678,41715,41661,41773,41667, -- Furious Gladiator's Sanctuary
                        41672,41683,41650,41767,41655, -- Furious Gladiator's Vestments
                        41854,41869,41859,41874,41864, -- Furious Gladiator's Investiture
                        41915,41934,41921,41940,41927, -- Furious Gladiator's Raiment
                        41946,41965,41953,41971,41959, -- Furious Gladiator's Regalia
                        41993,42011,41998,42017,42005, -- Furious Gladiator's Felshroud
                    },
                    ["Arena Season 7"] = {
                        40829,40870,40790,40810,40850, -- Relentless Gladiator's Battlegear
                        40831,40872,40772,40812,40852, -- Relentless Gladiator's Vindication
                        40934,40964,40910,40928,40940, -- Relentless Gladiator's Redemption
                        40830,40871,40791,40811,40851, -- Relentless Gladiator's Desecration
                        41020,41045,40995,41008,41034, -- Relentless Gladiator's Thunderfist
                        41152,41212,41082,41138,41200, -- Relentless Gladiator's Earthshaker
                        41014,41039,40994,41002,41028, -- Relentless Gladiator's Wartide
                        41158,41218,41088,41144,41206, -- Relentless Gladiator's Pursuit
                        41322,41276,41311,41288,41299, -- Relentless Gladiator's Refuge
                        41328,41282,41317,41294,41305, -- Relentless Gladiator's Wildhide
                        41679,41716,41662,41774,41668, -- Relentless Gladiator's Sanctuary
                        41673,41684,41651,41768,41656, -- Relentless Gladiator's Vestments
                        41855,41870,41860,41875,41865, -- Relentless Gladiator's Investiture
                        41916,41935,41922,41941,41928, -- Relentless Gladiator's Raiment
                        41947,41966,41954,41972,41960, -- Relentless Gladiator's Regalia
                        41994,42012,41999,42018,42006, -- Relentless Gladiator's Felshroud
                    },
                    ["Arena Season 8"] = {
                        51543,51545,51541,51542,51544, -- Wrathful Gladiator's Battlegear
                        51476,51479,51474,51475,51477, -- Wrathful Gladiator's Vindication
                        51470,51473,51468,51469,51471, -- Wrathful Gladiator's Redemption
                        51415,51418,51413,51414,51416, -- Wrathful Gladiator's Desecration
                        51511,51514,51509,51510,51512, -- Wrathful Gladiator's Thunderfist
                        51505,51508,51503,51504,51506, -- Wrathful Gladiator's Earthshaker
                        51499,51402,51497,51498,51500, -- Wrathful Gladiator's Wartide
                        51460,51463,51458,51459,51461, -- Wrathful Gladiator's Pursuit
                        51421,51424,51419,51420,51422, -- Wrathful Gladiator's Refuge
                        51435,51438,51433,51434,51436, -- Wrathful Gladiator's Wildhide
                        51427,51430,51425,51426,51428, -- Wrathful Gladiator's Sanctuary
                        51494,51491,51492,51493,51496, -- Wrathful Gladiator's Vestments
                        51484,51481,51482,51483,51485, -- Wrathful Gladiator's Investiture
                        51489,51486,51487,51488,51490, -- Wrathful Gladiator's Raiment
                        51465,51462,51463,51465,51466, -- Wrathful Gladiator's Regalia
                        51538,51540,51536,51537,51539, -- Wrathful Gladiator's Felshroud
                    },
                }
            }
        },
        ["Weapons"] = {
            ["PVP"] = {
                ["Honor"] = {
                    ["Arena Season 5 Hateful"] = { -- (200)
                        42025,42022,42020,42024,42026, -- Hateful Gladiator's Amulets
                        42021,42023,                   -- Hateful Gladiator's Amulets
                        42057,42058,42056,42059,42060, -- Hateful Gladiator's Cloaks
                        42055,42061,                   -- Hateful Gladiator's Cloaks
                        42110,42112,                   -- Hateful Gladiator's Rings
                        41638,41047,41332,41223,40972, -- Hateful Gladiator's Bracers
                        41063,40887,41907,41830,41878, -- Hateful Gladiator's Bracers
                        40877,40966,41877,41233,41330, -- Hateful Gladiator's Belts
                        41827,41050,41896,41068,41628, -- Hateful Gladiator's Belts
                        40878,41228,40973,41073,41331, -- Hateful Gladiator's Boots
                        41901,41633,41828,41049,41879, -- Hateful Gladiator's Boots
                    },
                    ["Arena Season 5 Deadly"] = { -- (213)
                        42031,42028,42029,42027,42032, -- Deadly Gladiator's Amulets
                        42030,42033,                   -- Deadly Gladiator's Amulets
                        42063,42067,42064,42062,42065, -- Deadly Gladiator's Cloaks
                        42068,42066,                   -- Deadly Gladiator's Cloaks
                        42115,42114,                   -- Deadly Gladiator's Rings
                        41908,41639,40888,41064,41224, -- Deadly Gladiator's Bracers
                        41059,41892,41839,40982,41624, -- Deadly Gladiator's Bracers
                        41069,40879,41234,41880,41897, -- Deadly Gladiator's Belts
                        40974,41629,41048,41616,41831, -- Deadly Gladiator's Belts
                        41229,41835,41884,40975,41054, -- Deadly Gladiator's Boots
                        40880,41074,41620,41634,41902, -- Deadly Gladiator's Boots
                    },
                    ["Arena Season 6"] = { -- (232)
                        42035,42034,42036,42037,42038, -- Furious Gladiator's Amulets
                        42040,46373,42039,             -- Furious Gladiator's Amulets
                        42075,42071,42074,42069,42070, -- Furious Gladiator's Cloaks
                        42073,42072,                   -- Furious Gladiator's Cloaks
                        42117,42116,                   -- Furious Gladiator's Rings
                        41840,40889,41909,41893,40983, -- Furious Gladiator's Bracers
                        41060,41640,41065,41225,41625, -- Furious Gladiator's Bracers
                        40976,41630,40881,41235,41832, -- Furious Gladiator's Belts
                        41898,41051,41070,41617,41881, -- Furious Gladiator's Belts
                        40882,41836,41230,40977,41635, -- Furious Gladiator's Boots
                        41885,41903,41621,41075,41055, -- Furious Gladiator's Boots
                    },
                    ["Arena Season 7"] = {  -- 245
                        42043,42042,42047,42044,46374, -- Relentless Gladiator's Amulets
                        42041,42045,42046,             -- Relentless Gladiator's Amulets
                        42081,42078,42082,42079,42076, -- Relentless Gladiator's Cloaks
                        42080,42077,                   -- Relentless Gladiator's Cloaks
                        42118,42119,                   -- Relentless Gladiator's Rings
                        41626,41226,41061,40984,41894, -- Relentless Gladiator's Bracers
                        49181,40890,41841,41910,41066, -- Relentless Gladiator's Bracers
                        41641,                         -- Relentless Gladiator's Bracers
                        40883,41236,41618,49179,40978, -- Relentless Gladiator's Belts
                        41833,41882,41899,41052,41071, -- Relentless Gladiator's Belts
                        41631,                         -- Relentless Gladiator's Belts
                        40884,41837,40979,49183,41231, -- Relentless Gladiator's Boots
                        41886,41904,41622,41056,41076, -- Relentless Gladiator's Boots
                        41636,                         -- Relentless Gladiator's Boots
                    },
                    ["Arena Season 8"] = { -- 264
                        51357,51355,51333,51331,51335, -- Wrathful Gladiator's Amulets
                        51347,51353,51349,             -- Wrathful Gladiator's Amulets
                        51332,51346,51354,51356,51330, -- Wrathful Gladiator's Cloaks
                        51334,51348,                   -- Wrathful Gladiator's Cloaks
                        51358,51336,                   -- Wrathful Gladiator's Rings
                        51370,51339,51364,51329,51352, -- Wrathful Gladiator's Bracers
                        51345,51361,51367,51342,51376, -- Wrathful Gladiator's Bracers
                        51373,                         -- Wrathful Gladiator's Bracers
                        51365,51362,51337,51368,51350, -- Wrathful Gladiator's Belts
                        51340,51359,51371,51327,51343, -- Wrathful Gladiator's Belts
                        51374,                         -- Wrathful Gladiator's Belts
                        51369,51363,51366,51360,51338, -- Wrathful Gladiator's Boots
                        51372,51351,51375,51341,51344, -- Wrathful Gladiator's Boots
                        51328,                         -- Wrathful Gladiator's Boots
                    },
                },
                ["Arena"] = {
                    ["Arena Season 5 Hateful"] = { -- (200)
                        42449,42207,42226,42231,42236, -- Hateful Gladiator's One-Handed Weapons
                        42241,42247,42254,42259,42264, -- Hateful Gladiator's One-Handed Weapons
                        42269,42274,42279,42284,42289, -- Hateful Gladiator's One-Handed Weapons
                        42345,42351,                   -- Hateful Gladiator's One-Handed Weapons
                        42484,42489,42494,42501,42512, -- Hateful Gladiator's Ranged Weapons and Wands
                        42518,                         -- Hateful Gladiator's Ranged Weapons and Wands
                        42316,42321,42326,42331,42359, -- Hateful Gladiator's Two-Handed Weapons
                        42383,42389,44417,44418,       -- Hateful Gladiator's Two-Handed Weapons
                        42563,42569,42524,42558,42536, -- Hateful Gladiator's Offhands and Shields
                        42530,                         -- Hateful Gladiator's Offhands and Shields
                        42851,42577,42619,42601,42582, -- Hateful Gladiator's Relics
                        42587,42596,42606,42613,       -- Hateful Gladiator's Relics
                    },
                    ["Arena Season 5 Deadly"] = { -- (213)
                        42208,42237,42232,42280,42270, -- Deadly Gladiator's One-Handed Weapons
                        42255,42260,42265,42290,42227, -- Deadly Gladiator's One-Handed Weapons
                        42346,42275,42285,42248,42352, -- Deadly Gladiator's One-Handed Weapons
                        42242,                         -- Deadly Gladiator's One-Handed Weapons
                        42495,42519,42490,42513,42485, -- Deadly Gladiator's Ranged Weapons and Wands
                        42502,                         -- Deadly Gladiator's Ranged Weapons and Wands
                        44420,42322,42327,42317,42390, -- Deadly Gladiator's Two-Handed Weapons
                        42332,42362,44419,42384,       -- Deadly Gladiator's Two-Handed Weapons
                        42559,42564,42525,42537,42570, -- Deadly Gladiator's Offhands and Shields
                        42531,                         -- Deadly Gladiator's Offhands and Shields
                        42852,42614,42583,42607,42597, -- Deadly Gladiator's Relics
                        42602,42620,42578,42588,       -- Deadly Gladiator's Relics
                    },
                    ["Arena Season 6"] = {  -- 232
                        42281,42233,42209,42353,42228, -- Furious Gladiator's One-Handed Weapons
                        42266,42271,42256,42276,42291, -- Furious Gladiator's One-Handed Weapons
                        42261,42243,42249,42286,42347, -- Furious Gladiator's One-Handed Weapons
                        42238,                         -- Furious Gladiator's One-Handed Weapons
                        42491,42520,42503,42486,42451, -- Furious Gladiator's Ranged Weapons and Wands
                        42514,42496,                   -- Furious Gladiator's Ranged Weapons and Wands
                        42391,42333,42318,42323,42328, -- Furious Gladiator's Two-Handed Weapons
                        44421,44422,42364,42385,       -- Furious Gladiator's Two-Handed Weapons
                                            -- 238
                        42560,42526,42538,42565,42532, -- Furious Gladiator's Offhands and Shields
                        42571,                         -- Furious Gladiator's Offhands and Shields
                        42853,42621,42608,42615,42579, -- Furious Gladiator's Relics
                        42589,42603,42584,42598,       -- Furious Gladiator's Relics
                                            -- 251
                        45961,45962,45967,45969,45957, -- Furious Gladiator's One-Handed Weapons (Elite)
                        45968,45963,45960,45970,45964, -- Furious Gladiator's One-Handed Weapons (Elite)
                        45971,45958,45966,45965,45959, -- Furious Gladiator's One-Handed Weapons (Elite)
                        45938,45937,45939,             -- Furious Gladiator's Ranged Weapons and Wands (Elite)
                        45948,45950,45951,45952,45949, -- Furious Gladiator's Two-Handed Weapons (Elite)
                        45953,45954,45955,45956,       -- Furious Gladiator's Two-Handed Weapons (Elite)
                    },
                    ["Arena Season 7"] = {  -- 245
                        42354,42262,42210,42257,42267, -- Relentless Gladiator's One-Handed Weapons
                        42272,42287,42292,42277,42348, -- Relentless Gladiator's One-Handed Weapons
                        42244,42282,42229,42234,42250, -- Relentless Gladiator's One-Handed Weapons
                        49189,                         -- Relentless Gladiator's One-Handed Weapons
                        42492,42487,42521,49185,42504, -- Relentless Gladiator's Ranged Weapons and Wands
                        42483,42515,42498,             -- Relentless Gladiator's Ranged Weapons and Wands
                        42319,42334,42329,44424,42366, -- Relentless Gladiator's Two-Handed Weapons
                        42392,42324,42386,44423,       -- Relentless Gladiator's Two-Handed Weapons
                                            -- 251
                        49187,42539,42561,42566,42572, -- Relentless Gladiator's Offhands and Shields
                        42527,42533,                   -- Relentless Gladiator's Offhands and Shields
                        42854,42604,42616,42622,42580, -- Relentless Gladiator's Relics
                        42591,42599,42609,42585,       -- Relentless Gladiator's Relics
                                            -- 258
                        48519,49191,48426,48408,48509, -- Relentless Gladiator's One-Handed Weapons (Elite)
                        48513,48507,48432,48438,48440, -- Relentless Gladiator's One-Handed Weapons (Elite)
                        48511,48428,48442,48515,48435, -- Relentless Gladiator's One-Handed Weapons (Elite)
                        48444,                         -- Relentless Gladiator's One-Handed Weapons (Elite)
                        48420,48422,48424,             -- Relentless Gladiator's Ranged Weapons and Wands (Elite)
                        48402,48406,48523,48404,48521, -- Relentless Gladiator's Two-Handed Weapons (Elite)
                        48414,48517,48412,48410,       -- Relentless Gladiator's Two-Handed Weapons (Elite)
                    },
                    ["Arena Season 8"] = { -- 264
                        51441,51517,51525,51439,51447, -- Wrathful Gladiator's One-Handed Weapons
                        51515,51523,51453,51530,51445, -- Wrathful Gladiator's One-Handed Weapons
                        51519,51406,51443,51527,51397, -- Wrathful Gladiator's One-Handed Weapons
                        51521,                         -- Wrathful Gladiator's One-Handed Weapons
                        51394,51451,51449,51531,51532, -- Wrathful Gladiator's Ranged Weapons and Wands
                        51411,51535,51410,             -- Wrathful Gladiator's Ranged Weapons and Wands
                        51392,51388,51431,51456,51404, -- Wrathful Gladiator's Two-Handed Weapons
                        51390,51400,51480,51402,       -- Wrathful Gladiator's Two-Handed Weapons
                                        -- 270
                        51407,51455,51408,51452,51533, -- Wrathful Gladiator's Offhands and Shields
                        51396,51409,                   -- Wrathful Gladiator's Offhands and Shields
                        51472,51501,51478,51429,51513, -- Wrathful Gladiator's Relics
                        51507,51417,51423,51437,       -- Wrathful Gladiator's Relics
                                        -- 277
                        51398,51454,51520,51448,51518, -- Wrathful Gladiator's One-Handed Weapons (Elite)
                        51440,51444,51516,51526,51522, -- Wrathful Gladiator's One-Handed Weapons (Elite)
                        51442,51529,51446,51399,51524, -- Wrathful Gladiator's One-Handed Weapons (Elite)
                        51528,                         -- Wrathful Gladiator's One-Handed Weapons (Elite)
                        51395,51450,51412,             -- Wrathful Gladiator's Ranged Weapons and Wands (Elite)
                        51432,51389,51393,51457,51401, -- Wrathful Gladiator's Two-Handed Weapons (Elite)
                        51391,51403,51405,51481,       -- Wrathful Gladiator's Two-Handed Weapons (Elite)
                    },
                }
            }
        },
    }
end

-- return data to main file
addon.db = db