local MOD = DugisGuideViewer
local _
local MapOverlays = MOD:RegisterModule("MapOverlays")
MapOverlays.essential = true
local harvestingDataMode = false

local HBDMigrate = LibStub("HereBeDragons-Migrate-Dugis")

function MapOverlays:Initialize()
	local defaults = {
		global = {
			overlayData = {
				     
[1194] = {
    {
        ["offsetX"]=464,
        ["textureHeight"] = 110,
        ["textureWidth"] = 128,
        ["offsetY"] = 33,
        ["fileDataIDs"] = { 271427 } 
    },
    {
        ["offsetX"]=413,
        ["textureHeight"] = 120,
        ["textureWidth"] = 160,
        ["offsetY"] = 476,
        ["fileDataIDs"] = { 2212659 } 
    },
    {
        ["offsetX"]=474,
        ["textureHeight"] = 190,
        ["textureWidth"] = 160,
        ["offsetY"] = 384,
        ["fileDataIDs"] = { 271426 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 180,
        ["textureWidth"] = 190,
        ["offsetY"] = 286,
        ["fileDataIDs"] = { 271440 } 
    },
    {
        ["offsetX"]=327,
        ["textureHeight"] = 200,
        ["textureWidth"] = 190,
        ["offsetY"] = 60,
        ["fileDataIDs"] = { 271439 } 
    },
    {
        ["offsetX"]=549,
        ["textureHeight"] = 240,
        ["textureWidth"] = 200,
        ["offsetY"] = 427,
        ["fileDataIDs"] = { 271437 } 
    },
    {
        ["offsetX"]=427,
        ["textureHeight"] = 160,
        ["textureWidth"] = 210,
        ["offsetY"] = 78,
        ["fileDataIDs"] = { 271428 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 215,
        ["textureWidth"] = 215,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 271443 } 
    },
    {
        ["offsetX"]=432,
        ["textureHeight"] = 230,
        ["textureWidth"] = 220,
        ["offsetY"] = 170,
        ["fileDataIDs"] = { 271421 } 
    },
    {
        ["offsetX"]=301,
        ["textureHeight"] = 230,
        ["textureWidth"] = 230,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 271422 } 
    },
    {
        ["offsetX"]=244,
        ["textureHeight"] = 160,
        ["textureWidth"] = 445,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271435,271442 } 
    }
},
[1200] = {
    {
        ["offsetX"]=473,
        ["textureHeight"] = 120,
        ["textureWidth"] = 128,
        ["offsetY"] = 260,
        ["fileDataIDs"] = { 272185 } 
    },
    {
        ["offsetX"]=379,
        ["textureHeight"] = 155,
        ["textureWidth"] = 128,
        ["offsetY"] = 242,
        ["fileDataIDs"] = { 272178 } 
    },
    {
        ["offsetX"]=303,
        ["textureHeight"] = 205,
        ["textureWidth"] = 128,
        ["offsetY"] = 307,
        ["fileDataIDs"] = { 272176 } 
    },
    {
        ["offsetX"]=458,
        ["textureHeight"] = 128,
        ["textureWidth"] = 170,
        ["offsetY"] = 369,
        ["fileDataIDs"] = { 272180 } 
    },
    {
        ["offsetX"]=291,
        ["textureHeight"] = 128,
        ["textureWidth"] = 185,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272172 } 
    },
    {
        ["offsetX"]=395,
        ["textureHeight"] = 128,
        ["textureWidth"] = 205,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272179 } 
    },
    {
        ["offsetX"]=502,
        ["textureHeight"] = 230,
        ["textureWidth"] = 205,
        ["offsetY"] = 16,
        ["fileDataIDs"] = { 272169 } 
    },
    {
        ["offsetX"]=255,
        ["textureHeight"] = 180,
        ["textureWidth"] = 210,
        ["offsetY"] = 214,
        ["fileDataIDs"] = { 272181 } 
    },
    {
        ["offsetX"]=428,
        ["textureHeight"] = 240,
        ["textureWidth"] = 215,
        ["offsetY"] = 80,
        ["fileDataIDs"] = { 272177 } 
    },
    {
        ["offsetX"]=532,
        ["textureHeight"] = 235,
        ["textureWidth"] = 225,
        ["offsetY"] = 238,
        ["fileDataIDs"] = { 272186 } 
    },
    {
        ["offsetX"]=523,
        ["textureHeight"] = 190,
        ["textureWidth"] = 256,
        ["offsetY"] = 356,
        ["fileDataIDs"] = { 272170 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 200,
        ["textureWidth"] = 256,
        ["offsetY"] = 303,
        ["fileDataIDs"] = { 272173 } 
    },
    {
        ["offsetX"]=249,
        ["textureHeight"] = 240,
        ["textureWidth"] = 280,
        ["offsetY"] = 59,
        ["fileDataIDs"] = { 272187,272171 } 
    },
    {
        ["offsetX"]=270,
        ["textureHeight"] = 243,
        ["textureWidth"] = 470,
        ["offsetY"] = 425,
        ["fileDataIDs"] = { 272168,272165 } 
    }
},
[1202] = {
    {
        ["offsetX"]=581,
        ["textureHeight"] = 100,
        ["textureWidth"] = 95,
        ["offsetY"] = 247,
        ["fileDataIDs"] = { 270573 } 
    },
    {
        ["offsetX"]=564,
        ["textureHeight"] = 165,
        ["textureWidth"] = 100,
        ["offsetY"] = 52,
        ["fileDataIDs"] = { 270569 } 
    },
    {
        ["offsetX"]=507,
        ["textureHeight"] = 110,
        ["textureWidth"] = 115,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 852702 } 
    },
    {
        ["offsetX"]=555,
        ["textureHeight"] = 110,
        ["textureWidth"] = 120,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270553 } 
    },
    {
        ["offsetX"]=384,
        ["textureHeight"] = 125,
        ["textureWidth"] = 120,
        ["offsetY"] = 115,
        ["fileDataIDs"] = { 270560 } 
    },
    {
        ["offsetX"]=492,
        ["textureHeight"] = 115,
        ["textureWidth"] = 125,
        ["offsetY"] = 63,
        ["fileDataIDs"] = { 270584 } 
    },
    {
        ["offsetX"]=556,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 270585 } 
    },
    {
        ["offsetX"]=442,
        ["textureHeight"] = 165,
        ["textureWidth"] = 125,
        ["offsetY"] = 298,
        ["fileDataIDs"] = { 852696 } 
    },
    {
        ["offsetX"]=412,
        ["textureHeight"] = 100,
        ["textureWidth"] = 128,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 852705 } 
    },
    {
        ["offsetX"]=419,
        ["textureHeight"] = 105,
        ["textureWidth"] = 128,
        ["offsetY"] = 63,
        ["fileDataIDs"] = { 270554 } 
    },
    {
        ["offsetX"]=306,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 130,
        ["fileDataIDs"] = { 852699 } 
    },
    {
        ["offsetX"]=341,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 537,
        ["fileDataIDs"] = { 852704 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 479,
        ["fileDataIDs"] = { 852694 } 
    },
    {
        ["offsetX"]=498,
        ["textureHeight"] = 128,
        ["textureWidth"] = 140,
        ["offsetY"] = 119,
        ["fileDataIDs"] = { 270574 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 125,
        ["textureWidth"] = 145,
        ["offsetY"] = 350,
        ["fileDataIDs"] = { 852697 } 
    },
    {
        ["offsetX"]=527,
        ["textureHeight"] = 120,
        ["textureWidth"] = 150,
        ["offsetY"] = 307,
        ["fileDataIDs"] = { 852701 } 
    },
    {
        ["offsetX"]=407,
        ["textureHeight"] = 115,
        ["textureWidth"] = 155,
        ["offsetY"] = 553,
        ["fileDataIDs"] = { 852703 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 128,
        ["textureWidth"] = 155,
        ["offsetY"] = 462,
        ["fileDataIDs"] = { 852695 } 
    },
    {
        ["offsetX"]=481,
        ["textureHeight"] = 128,
        ["textureWidth"] = 155,
        ["offsetY"] = 211,
        ["fileDataIDs"] = { 270565 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 155,
        ["textureWidth"] = 155,
        ["offsetY"] = 118,
        ["fileDataIDs"] = { 270559 } 
    },
    {
        ["offsetX"]=456,
        ["textureHeight"] = 120,
        ["textureWidth"] = 170,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270564 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 185,
        ["textureWidth"] = 175,
        ["offsetY"] = 177,
        ["fileDataIDs"] = { 852700 } 
    },
    {
        ["offsetX"]=317,
        ["textureHeight"] = 145,
        ["textureWidth"] = 200,
        ["offsetY"] = 29,
        ["fileDataIDs"] = { 270572 } 
    },
    {
        ["offsetX"]=340,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 852693 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 150,
        ["textureWidth"] = 210,
        ["offsetY"] = 402,
        ["fileDataIDs"] = { 852698 } 
    }
},
[1205] = {
    {
        ["offsetX"]=225,
        ["textureHeight"] = 175,
        ["textureWidth"] = 160,
        ["offsetY"] = 478,
        ["fileDataIDs"] = { 768731 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 197,
        ["textureWidth"] = 165,
        ["offsetY"] = 471,
        ["fileDataIDs"] = { 768752 } 
    },
    {
        ["offsetX"]=317,
        ["textureHeight"] = 170,
        ["textureWidth"] = 190,
        ["offsetY"] = 372,
        ["fileDataIDs"] = { 768732 } 
    },
    {
        ["offsetX"]=399,
        ["textureHeight"] = 288,
        ["textureWidth"] = 195,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 768721,768722 } 
    },
    {
        ["offsetX"]=406,
        ["textureHeight"] = 200,
        ["textureWidth"] = 200,
        ["offsetY"] = 279,
        ["fileDataIDs"] = { 768730 } 
    },
    {
        ["offsetX"]=196,
        ["textureHeight"] = 280,
        ["textureWidth"] = 220,
        ["offsetY"] = 131,
        ["fileDataIDs"] = { 768738,769205 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 200,
        ["textureWidth"] = 235,
        ["offsetY"] = 77,
        ["fileDataIDs"] = { 768753 } 
    },
    {
        ["offsetX"]=270,
        ["textureHeight"] = 255,
        ["textureWidth"] = 255,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 768739 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 320,
        ["textureWidth"] = 255,
        ["offsetY"] = 307,
        ["fileDataIDs"] = { 768744,768745 } 
    },
    {
        ["offsetX"]=334,
        ["textureHeight"] = 240,
        ["textureWidth"] = 280,
        ["offsetY"] = 162,
        ["fileDataIDs"] = { 768723,769200 } 
    },
    {
        ["offsetX"]=276,
        ["textureHeight"] = 230,
        ["textureWidth"] = 285,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 768728,768729 } 
    },
    {
        ["offsetX"]=26,
        ["textureHeight"] = 300,
        ["textureWidth"] = 300,
        ["offsetY"] = 262,
        ["fileDataIDs"] = { 769201,769202,769203,769204 } 
    },
    {
        ["offsetX"]=44,
        ["textureHeight"] = 265,
        ["textureWidth"] = 330,
        ["offsetY"] = 403,
        ["fileDataIDs"] = { 768734,768735,768736,768737 } 
    },
    {
        ["offsetX"]=626,
        ["textureHeight"] = 370,
        ["textureWidth"] = 350,
        ["offsetY"] = 253,
        ["fileDataIDs"] = { 768717,768718,768719,768720 } 
    },
    {
        ["offsetX"]=549,
        ["textureHeight"] = 300,
        ["textureWidth"] = 370,
        ["offsetY"] = 105,
        ["fileDataIDs"] = { 768748,768749,768750,768751 } 
    }
},
[1206] = {
    {
        ["offsetX"]=558,
        ["textureHeight"] = 230,
        ["textureWidth"] = 160,
        ["offsetY"] = 112,
        ["fileDataIDs"] = { 270360 } 
    },
    {
        ["offsetX"]=419,
        ["textureHeight"] = 155,
        ["textureWidth"] = 170,
        ["offsetY"] = 293,
        ["fileDataIDs"] = { 2212546 } 
    },
    {
        ["offsetX"]=370,
        ["textureHeight"] = 225,
        ["textureWidth"] = 175,
        ["offsetY"] = 186,
        ["fileDataIDs"] = { 270352 } 
    },
    {
        ["offsetX"]=472,
        ["textureHeight"] = 210,
        ["textureWidth"] = 180,
        ["offsetY"] = 165,
        ["fileDataIDs"] = { 270350 } 
    },
    {
        ["offsetX"]=138,
        ["textureHeight"] = 210,
        ["textureWidth"] = 190,
        ["offsetY"] = 54,
        ["fileDataIDs"] = { 270347 } 
    },
    {
        ["offsetX"]=87,
        ["textureHeight"] = 240,
        ["textureWidth"] = 190,
        ["offsetY"] = 138,
        ["fileDataIDs"] = { 2212539 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 220,
        ["textureWidth"] = 200,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 270348 } 
    },
    {
        ["offsetX"]=655,
        ["textureHeight"] = 250,
        ["textureWidth"] = 205,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 270336 } 
    },
    {
        ["offsetX"]=286,
        ["textureHeight"] = 185,
        ["textureWidth"] = 210,
        ["offsetY"] = 310,
        ["fileDataIDs"] = { 270346 } 
    },
    {
        ["offsetX"]=559,
        ["textureHeight"] = 210,
        ["textureWidth"] = 215,
        ["offsetY"] = 333,
        ["fileDataIDs"] = { 270353 } 
    },
    {
        ["offsetX"]=432,
        ["textureHeight"] = 235,
        ["textureWidth"] = 215,
        ["offsetY"] = 362,
        ["fileDataIDs"] = { 270342 } 
    },
    {
        ["offsetX"]=531,
        ["textureHeight"] = 195,
        ["textureWidth"] = 230,
        ["offsetY"] = 276,
        ["fileDataIDs"] = { 270343 } 
    },
    {
        ["offsetX"]=192,
        ["textureHeight"] = 240,
        ["textureWidth"] = 230,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 270351 } 
    },
    {
        ["offsetX"]=108,
        ["textureHeight"] = 230,
        ["textureWidth"] = 240,
        ["offsetY"] = 287,
        ["fileDataIDs"] = { 270358 } 
    },
    {
        ["offsetX"]=232,
        ["textureHeight"] = 245,
        ["textureWidth"] = 245,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 270349 } 
    },
    {
        ["offsetX"]=171,
        ["textureHeight"] = 215,
        ["textureWidth"] = 256,
        ["offsetY"] = 424,
        ["fileDataIDs"] = { 270361 } 
    }
},
[1207] = {
    {
        ["offsetX"]=325,
        ["textureHeight"] = 200,
        ["textureWidth"] = 195,
        ["offsetY"] = 148,
        ["fileDataIDs"] = { 270543 } 
    },
    {
        ["offsetX"]=445,
        ["textureHeight"] = 195,
        ["textureWidth"] = 200,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 270532 } 
    },
    {
        ["offsetX"]=551,
        ["textureHeight"] = 220,
        ["textureWidth"] = 220,
        ["offsetY"] = 48,
        ["fileDataIDs"] = { 270530 } 
    },
    {
        ["offsetX"]=349,
        ["textureHeight"] = 230,
        ["textureWidth"] = 230,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 2212608 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 255,
        ["textureWidth"] = 240,
        ["offsetY"] = 148,
        ["fileDataIDs"] = { 2212593 } 
    },
    {
        ["offsetX"]=389,
        ["textureHeight"] = 205,
        ["textureWidth"] = 245,
        ["offsetY"] = 7,
        ["fileDataIDs"] = { 2212606 } 
    },
    {
        ["offsetX"]=498,
        ["textureHeight"] = 205,
        ["textureWidth"] = 245,
        ["offsetY"] = 209,
        ["fileDataIDs"] = { 2212592 } 
    },
    {
        ["offsetX"]=17,
        ["textureHeight"] = 205,
        ["textureWidth"] = 255,
        ["offsetY"] = 310,
        ["fileDataIDs"] = { 270529 } 
    },
    {
        ["offsetX"]=12,
        ["textureHeight"] = 220,
        ["textureWidth"] = 255,
        ["offsetY"] = 428,
        ["fileDataIDs"] = { 270520 } 
    },
    {
        ["offsetX"]=501,
        ["textureHeight"] = 280,
        ["textureWidth"] = 255,
        ["offsetY"] = 341,
        ["fileDataIDs"] = { 270540,270527 } 
    },
    {
        ["offsetX"]=345,
        ["textureHeight"] = 270,
        ["textureWidth"] = 265,
        ["offsetY"] = 389,
        ["fileDataIDs"] = { 270522,270550,270528,270536 } 
    },
    {
        ["offsetX"]=159,
        ["textureHeight"] = 275,
        ["textureWidth"] = 270,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 270525,270521,2212603,2212605 } 
    },
    {
        ["offsetX"]=148,
        ["textureHeight"] = 240,
        ["textureWidth"] = 285,
        ["offsetY"] = 384,
        ["fileDataIDs"] = { 2212599,2212601 } 
    },
    {
        ["offsetX"]=611,
        ["textureHeight"] = 455,
        ["textureWidth"] = 370,
        ["offsetY"] = 110,
        ["fileDataIDs"] = { 270534,270551,270546,270535 } 
    }
},
[1209] = {
    {
        ["offsetX"]=405,
        ["textureHeight"] = 145,
        ["textureWidth"] = 170,
        ["offsetY"] = 123,
        ["fileDataIDs"] = { 391431 } 
    },
    {
        ["offsetX"]=472,
        ["textureHeight"] = 200,
        ["textureWidth"] = 170,
        ["offsetY"] = 9,
        ["fileDataIDs"] = { 391433 } 
    },
    {
        ["offsetX"]=310,
        ["textureHeight"] = 155,
        ["textureWidth"] = 185,
        ["offsetY"] = 133,
        ["fileDataIDs"] = { 391425 } 
    },
    {
        ["offsetX"]=559,
        ["textureHeight"] = 190,
        ["textureWidth"] = 185,
        ["offsetY"] = 30,
        ["fileDataIDs"] = { 391432 } 
    },
    {
        ["offsetX"]=361,
        ["textureHeight"] = 180,
        ["textureWidth"] = 195,
        ["offsetY"] = 15,
        ["fileDataIDs"] = { 391435 } 
    },
    {
        ["offsetX"]=501,
        ["textureHeight"] = 170,
        ["textureWidth"] = 225,
        ["offsetY"] = 140,
        ["fileDataIDs"] = { 391430 } 
    },
    {
        ["offsetX"]=361,
        ["textureHeight"] = 195,
        ["textureWidth"] = 245,
        ["offsetY"] = 195,
        ["fileDataIDs"] = { 391434 } 
    },
    {
        ["offsetX"]=453,
        ["textureHeight"] = 220,
        ["textureWidth"] = 265,
        ["offsetY"] = 259,
        ["fileDataIDs"] = { 391437,391436 } 
    },
    {
        ["offsetX"]=212,
        ["textureHeight"] = 450,
        ["textureWidth"] = 384,
        ["offsetY"] = 178,
        ["fileDataIDs"] = { 391429,391428,391427,391426 } 
    }
},
[1210] = {
    {
        ["offsetX"]=537,
        ["textureHeight"] = 158,
        ["textureWidth"] = 128,
        ["offsetY"] = 299,
        ["fileDataIDs"] = { 273015 } 
    },
    {
        ["offsetX"]=474,
        ["textureHeight"] = 128,
        ["textureWidth"] = 150,
        ["offsetY"] = 327,
        ["fileDataIDs"] = { 273016 } 
    },
    {
        ["offsetX"]=694,
        ["textureHeight"] = 128,
        ["textureWidth"] = 173,
        ["offsetY"] = 289,
        ["fileDataIDs"] = { 273000 } 
    },
    {
        ["offsetX"]=497,
        ["textureHeight"] = 220,
        ["textureWidth"] = 174,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 273020 } 
    },
    {
        ["offsetX"]=689,
        ["textureHeight"] = 247,
        ["textureWidth"] = 175,
        ["offsetY"] = 104,
        ["fileDataIDs"] = { 272996 } 
    },
    {
        ["offsetX"]=395,
        ["textureHeight"] = 128,
        ["textureWidth"] = 186,
        ["offsetY"] = 277,
        ["fileDataIDs"] = { 2213434 } 
    },
    {
        ["offsetX"]=587,
        ["textureHeight"] = 288,
        ["textureWidth"] = 201,
        ["offsetY"] = 139,
        ["fileDataIDs"] = { 273009,273002 } 
    },
    {
        ["offsetX"]=746,
        ["textureHeight"] = 189,
        ["textureWidth"] = 211,
        ["offsetY"] = 125,
        ["fileDataIDs"] = { 2213425 } 
    },
    {
        ["offsetX"]=630,
        ["textureHeight"] = 179,
        ["textureWidth"] = 216,
        ["offsetY"] = 326,
        ["fileDataIDs"] = { 273006 } 
    },
    {
        ["offsetX"]=698,
        ["textureHeight"] = 205,
        ["textureWidth"] = 230,
        ["offsetY"] = 362,
        ["fileDataIDs"] = { 2213418 } 
    },
    {
        ["offsetX"]=757,
        ["textureHeight"] = 214,
        ["textureWidth"] = 237,
        ["offsetY"] = 205,
        ["fileDataIDs"] = { 272999 } 
    },
    {
        ["offsetX"]=363,
        ["textureHeight"] = 199,
        ["textureWidth"] = 243,
        ["offsetY"] = 349,
        ["fileDataIDs"] = { 273003 } 
    },
    {
        ["offsetX"]=227,
        ["textureHeight"] = 205,
        ["textureWidth"] = 245,
        ["offsetY"] = 328,
        ["fileDataIDs"] = { 273001 } 
    },
    {
        ["offsetX"]=239,
        ["textureHeight"] = 156,
        ["textureWidth"] = 256,
        ["offsetY"] = 250,
        ["fileDataIDs"] = { 273017 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 210,
        ["textureWidth"] = 256,
        ["offsetY"] = 139,
        ["fileDataIDs"] = { 273019 } 
    },
    {
        ["offsetX"]=463,
        ["textureHeight"] = 235,
        ["textureWidth"] = 315,
        ["offsetY"] = 361,
        ["fileDataIDs"] = { 2213428,2213430 } 
    }
},
[1211] = {
    {
        ["offsetX"]=391,
        ["textureHeight"] = 125,
        ["textureWidth"] = 140,
        ["offsetY"] = 446,
        ["fileDataIDs"] = { 2213067 } 
    },
    {
        ["offsetX"]=470,
        ["textureHeight"] = 170,
        ["textureWidth"] = 160,
        ["offsetY"] = 261,
        ["fileDataIDs"] = { 272598 } 
    },
    {
        ["offsetX"]=382,
        ["textureHeight"] = 185,
        ["textureWidth"] = 165,
        ["offsetY"] = 252,
        ["fileDataIDs"] = { 272616 } 
    },
    {
        ["offsetX"]=402,
        ["textureHeight"] = 165,
        ["textureWidth"] = 175,
        ["offsetY"] = 65,
        ["fileDataIDs"] = { 2213080 } 
    },
    {
        ["offsetX"]=323,
        ["textureHeight"] = 128,
        ["textureWidth"] = 180,
        ["offsetY"] = 128,
        ["fileDataIDs"] = { 2213065 } 
    },
    {
        ["offsetX"]=457,
        ["textureHeight"] = 185,
        ["textureWidth"] = 180,
        ["offsetY"] = 144,
        ["fileDataIDs"] = { 2213082 } 
    },
    {
        ["offsetX"]=286,
        ["textureHeight"] = 165,
        ["textureWidth"] = 185,
        ["offsetY"] = 37,
        ["fileDataIDs"] = { 272610 } 
    },
    {
        ["offsetX"]=352,
        ["textureHeight"] = 160,
        ["textureWidth"] = 210,
        ["offsetY"] = 168,
        ["fileDataIDs"] = { 272620 } 
    },
    {
        ["offsetX"]=379,
        ["textureHeight"] = 215,
        ["textureWidth"] = 210,
        ["offsetY"] = 447,
        ["fileDataIDs"] = { 272609 } 
    },
    {
        ["offsetX"]=364,
        ["textureHeight"] = 160,
        ["textureWidth"] = 220,
        ["offsetY"] = 359,
        ["fileDataIDs"] = { 272613 } 
    },
    {
        ["offsetX"]=491,
        ["textureHeight"] = 180,
        ["textureWidth"] = 240,
        ["offsetY"] = 417,
        ["fileDataIDs"] = { 272599 } 
    },
    {
        ["offsetX"]=494,
        ["textureHeight"] = 240,
        ["textureWidth"] = 240,
        ["offsetY"] = 262,
        ["fileDataIDs"] = { 272614 } 
    },
    {
        ["offsetX"]=593,
        ["textureHeight"] = 215,
        ["textureWidth"] = 250,
        ["offsetY"] = 74,
        ["fileDataIDs"] = { 272600 } 
    },
    {
        ["offsetX"]=465,
        ["textureHeight"] = 160,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213063 } 
    },
    {
        ["offsetX"]=459,
        ["textureHeight"] = 220,
        ["textureWidth"] = 256,
        ["offsetY"] = 13,
        ["fileDataIDs"] = { 2213084 } 
    }
},
[1212] = {
    {
        ["offsetX"]=300,
        ["textureHeight"] = 125,
        ["textureWidth"] = 160,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 273113 } 
    },
    {
        ["offsetX"]=566,
        ["textureHeight"] = 200,
        ["textureWidth"] = 160,
        ["offsetY"] = 198,
        ["fileDataIDs"] = { 273121 } 
    },
    {
        ["offsetX"]=600,
        ["textureHeight"] = 165,
        ["textureWidth"] = 170,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 273107 } 
    },
    {
        ["offsetX"]=451,
        ["textureHeight"] = 190,
        ["textureWidth"] = 170,
        ["offsetY"] = 323,
        ["fileDataIDs"] = { 273102 } 
    },
    {
        ["offsetX"]=520,
        ["textureHeight"] = 205,
        ["textureWidth"] = 180,
        ["offsetY"] = 250,
        ["fileDataIDs"] = { 273094 } 
    },
    {
        ["offsetX"]=590,
        ["textureHeight"] = 340,
        ["textureWidth"] = 205,
        ["offsetY"] = 86,
        ["fileDataIDs"] = { 273122,273103 } 
    },
    {
        ["offsetX"]=381,
        ["textureHeight"] = 150,
        ["textureWidth"] = 220,
        ["offsetY"] = 265,
        ["fileDataIDs"] = { 2212523 } 
    },
    {
        ["offsetX"]=382,
        ["textureHeight"] = 180,
        ["textureWidth"] = 220,
        ["offsetY"] = 164,
        ["fileDataIDs"] = { 273114 } 
    },
    {
        ["offsetX"]=137,
        ["textureHeight"] = 185,
        ["textureWidth"] = 225,
        ["offsetY"] = 293,
        ["fileDataIDs"] = { 273120 } 
    },
    {
        ["offsetX"]=260,
        ["textureHeight"] = 230,
        ["textureWidth"] = 285,
        ["offsetY"] = 355,
        ["fileDataIDs"] = { 2212522,2212521 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 206,
        ["textureWidth"] = 300,
        ["offsetY"] = 462,
        ["fileDataIDs"] = { 273108,273101 } 
    },
    {
        ["offsetX"]=307,
        ["textureHeight"] = 288,
        ["textureWidth"] = 340,
        ["offsetY"] = 16,
        ["fileDataIDs"] = { 273095,273111,273100,273090 } 
    },
    {
        ["offsetX"]=504,
        ["textureHeight"] = 270,
        ["textureWidth"] = 370,
        ["offsetY"] = 343,
        ["fileDataIDs"] = { 273119,273092,273112,273093 } 
    }
},
[1213] = {
    {
        ["offsetX"]=537,
        ["textureHeight"] = 160,
        ["textureWidth"] = 165,
        ["offsetY"] = 367,
        ["fileDataIDs"] = { 271544 } 
    },
    {
        ["offsetX"]=716,
        ["textureHeight"] = 245,
        ["textureWidth"] = 175,
        ["offsetY"] = 299,
        ["fileDataIDs"] = { 271533 } 
    },
    {
        ["offsetX"]=592,
        ["textureHeight"] = 160,
        ["textureWidth"] = 180,
        ["offsetY"] = 241,
        ["fileDataIDs"] = { 271542 } 
    },
    {
        ["offsetX"]=172,
        ["textureHeight"] = 150,
        ["textureWidth"] = 185,
        ["offsetY"] = 477,
        ["fileDataIDs"] = { 271512 } 
    },
    {
        ["offsetX"]=79,
        ["textureHeight"] = 205,
        ["textureWidth"] = 190,
        ["offsetY"] = 98,
        ["fileDataIDs"] = { 271522 } 
    },
    {
        ["offsetX"]=620,
        ["textureHeight"] = 205,
        ["textureWidth"] = 190,
        ["offsetY"] = 128,
        ["fileDataIDs"] = { 271520 } 
    },
    {
        ["offsetX"]=620,
        ["textureHeight"] = 275,
        ["textureWidth"] = 195,
        ["offsetY"] = 291,
        ["fileDataIDs"] = { 271543,271530 } 
    },
    {
        ["offsetX"]=156,
        ["textureHeight"] = 205,
        ["textureWidth"] = 200,
        ["offsetY"] = 360,
        ["fileDataIDs"] = { 271551 } 
    },
    {
        ["offsetX"]=291,
        ["textureHeight"] = 165,
        ["textureWidth"] = 205,
        ["offsetY"] = 401,
        ["fileDataIDs"] = { 271548 } 
    },
    {
        ["offsetX"]=614,
        ["textureHeight"] = 165,
        ["textureWidth"] = 205,
        ["offsetY"] = 30,
        ["fileDataIDs"] = { 271554 } 
    },
    {
        ["offsetX"]=409,
        ["textureHeight"] = 250,
        ["textureWidth"] = 205,
        ["offsetY"] = 345,
        ["fileDataIDs"] = { 2212700 } 
    },
    {
        ["offsetX"]=309,
        ["textureHeight"] = 179,
        ["textureWidth"] = 210,
        ["offsetY"] = 489,
        ["fileDataIDs"] = { 271514 } 
    },
    {
        ["offsetX"]=271,
        ["textureHeight"] = 210,
        ["textureWidth"] = 210,
        ["offsetY"] = 261,
        ["fileDataIDs"] = { 271536 } 
    },
    {
        ["offsetX"]=7,
        ["textureHeight"] = 360,
        ["textureWidth"] = 220,
        ["offsetY"] = 231,
        ["fileDataIDs"] = { 2212705,2212706 } 
    },
    {
        ["offsetX"]=722,
        ["textureHeight"] = 215,
        ["textureWidth"] = 225,
        ["offsetY"] = 166,
        ["fileDataIDs"] = { 271537 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 150,
        ["textureWidth"] = 230,
        ["offsetY"] = 36,
        ["fileDataIDs"] = { 271535 } 
    },
    {
        ["offsetX"]=442,
        ["textureHeight"] = 235,
        ["textureWidth"] = 230,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 271523 } 
    },
    {
        ["offsetX"]=457,
        ["textureHeight"] = 195,
        ["textureWidth"] = 240,
        ["offsetY"] = 109,
        ["fileDataIDs"] = { 271521 } 
    },
    {
        ["offsetX"]=194,
        ["textureHeight"] = 200,
        ["textureWidth"] = 240,
        ["offsetY"] = 9,
        ["fileDataIDs"] = { 271529 } 
    },
    {
        ["offsetX"]=717,
        ["textureHeight"] = 170,
        ["textureWidth"] = 245,
        ["offsetY"] = 471,
        ["fileDataIDs"] = { 271553 } 
    },
    {
        ["offsetX"]=537,
        ["textureHeight"] = 175,
        ["textureWidth"] = 250,
        ["offsetY"] = 463,
        ["fileDataIDs"] = { 271532 } 
    },
    {
        ["offsetX"]=169,
        ["textureHeight"] = 270,
        ["textureWidth"] = 360,
        ["offsetY"] = 83,
        ["fileDataIDs"] = { 271518,271527,2212703,2212704 } 
    }
},
[1214] = {
    {
        ["offsetX"]=109,
        ["textureHeight"] = 100,
        ["textureWidth"] = 125,
        ["offsetY"] = 482,
        ["fileDataIDs"] = { 271904 } 
    },
    {
        ["offsetX"]=175,
        ["textureHeight"] = 200,
        ["textureWidth"] = 165,
        ["offsetY"] = 275,
        ["fileDataIDs"] = { 2212736 } 
    },
    {
        ["offsetX"]=414,
        ["textureHeight"] = 155,
        ["textureWidth"] = 205,
        ["offsetY"] = 154,
        ["fileDataIDs"] = { 271897 } 
    },
    {
        ["offsetX"]=541,
        ["textureHeight"] = 240,
        ["textureWidth"] = 215,
        ["offsetY"] = 236,
        ["fileDataIDs"] = { 2212742 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 310,
        ["textureWidth"] = 220,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271894,2212744 } 
    },
    {
        ["offsetX"]=524,
        ["textureHeight"] = 320,
        ["textureWidth"] = 230,
        ["offsetY"] = 339,
        ["fileDataIDs"] = { 2212737,2212738 } 
    },
    {
        ["offsetX"]=418,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 201,
        ["fileDataIDs"] = { 271905,2212743 } 
    },
    {
        ["offsetX"]=637,
        ["textureHeight"] = 275,
        ["textureWidth"] = 240,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 271885,271877 } 
    },
    {
        ["offsetX"]=208,
        ["textureHeight"] = 155,
        ["textureWidth"] = 285,
        ["offsetY"] = 368,
        ["fileDataIDs"] = { 2212746,2212747 } 
    },
    {
        ["offsetX"]=2,
        ["textureHeight"] = 225,
        ["textureWidth"] = 288,
        ["offsetY"] = 192,
        ["fileDataIDs"] = { 271876,271881 } 
    },
    {
        ["offsetX"]=198,
        ["textureHeight"] = 275,
        ["textureWidth"] = 305,
        ["offsetY"] = 155,
        ["fileDataIDs"] = { 271883,271892,2212739,2212740 } 
    },
    {
        ["offsetX"]=605,
        ["textureHeight"] = 365,
        ["textureWidth"] = 384,
        ["offsetY"] = 75,
        ["fileDataIDs"] = { 271872,271898,271882,271891 } 
    }
},
[1215] = {
    {
        ["offsetX"]=158,
        ["textureHeight"] = 220,
        ["textureWidth"] = 145,
        ["offsetY"] = 149,
        ["fileDataIDs"] = { 271927 } 
    },
    {
        ["offsetX"]=512,
        ["textureHeight"] = 145,
        ["textureWidth"] = 160,
        ["offsetY"] = 232,
        ["fileDataIDs"] = { 271933 } 
    },
    {
        ["offsetX"]=319,
        ["textureHeight"] = 170,
        ["textureWidth"] = 170,
        ["offsetY"] = 302,
        ["fileDataIDs"] = { 271934 } 
    },
    {
        ["offsetX"]=693,
        ["textureHeight"] = 310,
        ["textureWidth"] = 170,
        ["offsetY"] = 303,
        ["fileDataIDs"] = { 271938,271916 } 
    },
    {
        ["offsetX"]=408,
        ["textureHeight"] = 170,
        ["textureWidth"] = 180,
        ["offsetY"] = 260,
        ["fileDataIDs"] = { 271929 } 
    },
    {
        ["offsetX"]=237,
        ["textureHeight"] = 195,
        ["textureWidth"] = 185,
        ["offsetY"] = 185,
        ["fileDataIDs"] = { 271928 } 
    },
    {
        ["offsetX"]=240,
        ["textureHeight"] = 185,
        ["textureWidth"] = 195,
        ["offsetY"] = 387,
        ["fileDataIDs"] = { 271937 } 
    },
    {
        ["offsetX"]=373,
        ["textureHeight"] = 165,
        ["textureWidth"] = 200,
        ["offsetY"] = 365,
        ["fileDataIDs"] = { 271922 } 
    },
    {
        ["offsetX"]=374,
        ["textureHeight"] = 195,
        ["textureWidth"] = 205,
        ["offsetY"] = 164,
        ["fileDataIDs"] = { 271910 } 
    },
    {
        ["offsetX"]=171,
        ["textureHeight"] = 200,
        ["textureWidth"] = 225,
        ["offsetY"] = 306,
        ["fileDataIDs"] = { 770218 } 
    },
    {
        ["offsetX"]=505,
        ["textureHeight"] = 285,
        ["textureWidth"] = 235,
        ["offsetY"] = 333,
        ["fileDataIDs"] = { 271912,271920 } 
    },
    {
        ["offsetX"]=13,
        ["textureHeight"] = 205,
        ["textureWidth"] = 255,
        ["offsetY"] = 245,
        ["fileDataIDs"] = { 271917 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 275,
        ["textureWidth"] = 275,
        ["offsetY"] = 19,
        ["fileDataIDs"] = { 271908,271935,271936,271909 } 
    },
    {
        ["offsetX"]=571,
        ["textureHeight"] = 205,
        ["textureWidth"] = 280,
        ["offsetY"] = 239,
        ["fileDataIDs"] = { 271915,271921 } 
    }
},
[1216] = {
    {
        ["offsetX"]=252,
        ["textureHeight"] = 115,
        ["textureWidth"] = 115,
        ["offsetY"] = 249,
        ["fileDataIDs"] = { 2212640 } 
    },
    {
        ["offsetX"]=217,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 287,
        ["fileDataIDs"] = { 271398 } 
    },
    {
        ["offsetX"]=792,
        ["textureHeight"] = 120,
        ["textureWidth"] = 128,
        ["offsetY"] = 279,
        ["fileDataIDs"] = { 2212654 } 
    },
    {
        ["offsetX"]=573,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 280,
        ["fileDataIDs"] = { 271389 } 
    },
    {
        ["offsetX"]=502,
        ["textureHeight"] = 165,
        ["textureWidth"] = 128,
        ["offsetY"] = 221,
        ["fileDataIDs"] = { 2212651 } 
    },
    {
        ["offsetX"]=759,
        ["textureHeight"] = 165,
        ["textureWidth"] = 128,
        ["offsetY"] = 173,
        ["fileDataIDs"] = { 2212653 } 
    },
    {
        ["offsetX"]=281,
        ["textureHeight"] = 180,
        ["textureWidth"] = 128,
        ["offsetY"] = 167,
        ["fileDataIDs"] = { 271392 } 
    },
    {
        ["offsetX"]=347,
        ["textureHeight"] = 190,
        ["textureWidth"] = 128,
        ["offsetY"] = 163,
        ["fileDataIDs"] = { 271418 } 
    },
    {
        ["offsetX"]=295,
        ["textureHeight"] = 128,
        ["textureWidth"] = 150,
        ["offsetY"] = 385,
        ["fileDataIDs"] = { 271406 } 
    },
    {
        ["offsetX"]=522,
        ["textureHeight"] = 128,
        ["textureWidth"] = 155,
        ["offsetY"] = 322,
        ["fileDataIDs"] = { 271401 } 
    },
    {
        ["offsetX"]=694,
        ["textureHeight"] = 170,
        ["textureWidth"] = 155,
        ["offsetY"] = 273,
        ["fileDataIDs"] = { 271409 } 
    },
    {
        ["offsetX"]=608,
        ["textureHeight"] = 165,
        ["textureWidth"] = 165,
        ["offsetY"] = 291,
        ["fileDataIDs"] = { 271408 } 
    },
    {
        ["offsetX"]=274,
        ["textureHeight"] = 128,
        ["textureWidth"] = 180,
        ["offsetY"] = 296,
        ["fileDataIDs"] = { 2212641 } 
    },
    {
        ["offsetX"]=166,
        ["textureHeight"] = 165,
        ["textureWidth"] = 180,
        ["offsetY"] = 184,
        ["fileDataIDs"] = { 2212644 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 271400 } 
    },
    {
        ["offsetX"]=386,
        ["textureHeight"] = 200,
        ["textureWidth"] = 200,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 271417 } 
    },
    {
        ["offsetX"]=155,
        ["textureHeight"] = 185,
        ["textureWidth"] = 240,
        ["offsetY"] = 403,
        ["fileDataIDs"] = { 2212639 } 
    },
    {
        ["offsetX"]=397,
        ["textureHeight"] = 200,
        ["textureWidth"] = 315,
        ["offsetY"] = 163,
        ["fileDataIDs"] = { 271410,271396 } 
    }
},
[1220] = {
    {
        ["offsetX"]=77,
        ["textureHeight"] = 235,
        ["textureWidth"] = 275,
        ["offsetY"] = 366,
        ["fileDataIDs"] = { 254503,254504 } 
    },
    {
        ["offsetX"]=494,
        ["textureHeight"] = 220,
        ["textureWidth"] = 305,
        ["offsetY"] = 300,
        ["fileDataIDs"] = { 2201968,2201949 } 
    },
    {
        ["offsetX"]=545,
        ["textureHeight"] = 230,
        ["textureWidth"] = 305,
        ["offsetY"] = 407,
        ["fileDataIDs"] = { 254527,254528 } 
    },
    {
        ["offsetX"]=247,
        ["textureHeight"] = 280,
        ["textureWidth"] = 360,
        ["offsetY"] = 388,
        ["fileDataIDs"] = { 2201972,2201970,2201969,2201971 } 
    },
    {
        ["offsetX"]=85,
        ["textureHeight"] = 430,
        ["textureWidth"] = 405,
        ["offsetY"] = 30,
        ["fileDataIDs"] = { 254509,254510,254511,254512 } 
    },
    {
        ["offsetX"]=250,
        ["textureHeight"] = 325,
        ["textureWidth"] = 425,
        ["offsetY"] = 170,
        ["fileDataIDs"] = { 254529,254530,254531,254532 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 365,
        ["textureWidth"] = 460,
        ["offsetY"] = 8,
        ["fileDataIDs"] = { 254505,254506,254507,254508 } 
    }
},
[1224] = {
    {
        ["offsetX"]=707,
        ["textureHeight"] = 225,
        ["textureWidth"] = 220,
        ["offsetY"] = 168,
        ["fileDataIDs"] = { 270927 } 
    },
    {
        ["offsetX"]=36,
        ["textureHeight"] = 220,
        ["textureWidth"] = 225,
        ["offsetY"] = 109,
        ["fileDataIDs"] = { 270938 } 
    },
    {
        ["offsetX"]=334,
        ["textureHeight"] = 265,
        ["textureWidth"] = 245,
        ["offsetY"] = 114,
        ["fileDataIDs"] = { 270912,270909 } 
    },
    {
        ["offsetX"]=173,
        ["textureHeight"] = 280,
        ["textureWidth"] = 256,
        ["offsetY"] = 101,
        ["fileDataIDs"] = { 270919,270911 } 
    },
    {
        ["offsetX"]=513,
        ["textureHeight"] = 285,
        ["textureWidth"] = 270,
        ["offsetY"] = 99,
        ["fileDataIDs"] = { 270922,270934,270923,270937 } 
    },
    {
        ["offsetX"]=589,
        ["textureHeight"] = 310,
        ["textureWidth"] = 270,
        ["offsetY"] = 279,
        ["fileDataIDs"] = { 270920,270914,270908,270929 } 
    },
    {
        ["offsetX"]=722,
        ["textureHeight"] = 355,
        ["textureWidth"] = 280,
        ["offsetY"] = 46,
        ["fileDataIDs"] = { 270944,270910,270935,270945 } 
    },
    {
        ["offsetX"]=708,
        ["textureHeight"] = 270,
        ["textureWidth"] = 294,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 270906,270918,270936,270942 } 
    },
    {
        ["offsetX"]=377,
        ["textureHeight"] = 270,
        ["textureWidth"] = 320,
        ["offsetY"] = 285,
        ["fileDataIDs"] = { 270933,270943,270921,270928 } 
    },
    {
        ["offsetX"]=56,
        ["textureHeight"] = 315,
        ["textureWidth"] = 415,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 270941,270925,270926,270917 } 
    }
},
[1228] = {
    {
        ["offsetX"]=422,
        ["textureHeight"] = 220,
        ["textureWidth"] = 225,
        ["offsetY"] = 332,
        ["fileDataIDs"] = { 271560 } 
    },
    {
        ["offsetX"]=250,
        ["textureHeight"] = 220,
        ["textureWidth"] = 240,
        ["offsetY"] = 270,
        ["fileDataIDs"] = { 271567 } 
    },
    {
        ["offsetX"]=551,
        ["textureHeight"] = 250,
        ["textureWidth"] = 255,
        ["offsetY"] = 292,
        ["fileDataIDs"] = { 271573 } 
    },
    {
        ["offsetX"]=704,
        ["textureHeight"] = 210,
        ["textureWidth"] = 256,
        ["offsetY"] = 330,
        ["fileDataIDs"] = { 271578 } 
    },
    {
        ["offsetX"]=425,
        ["textureHeight"] = 237,
        ["textureWidth"] = 256,
        ["offsetY"] = 431,
        ["fileDataIDs"] = { 271582 } 
    },
    {
        ["offsetX"]=238,
        ["textureHeight"] = 240,
        ["textureWidth"] = 256,
        ["offsetY"] = 428,
        ["fileDataIDs"] = { 271576 } 
    },
    {
        ["offsetX"]=577,
        ["textureHeight"] = 249,
        ["textureWidth"] = 256,
        ["offsetY"] = 419,
        ["fileDataIDs"] = { 271559 } 
    },
    {
        ["offsetX"]=381,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 147,
        ["fileDataIDs"] = { 271572 } 
    },
    {
        ["offsetX"]=124,
        ["textureHeight"] = 341,
        ["textureWidth"] = 256,
        ["offsetY"] = 327,
        ["fileDataIDs"] = { 2212708,2212709 } 
    },
    {
        ["offsetX"]=696,
        ["textureHeight"] = 233,
        ["textureWidth"] = 306,
        ["offsetY"] = 435,
        ["fileDataIDs"] = { 271557,271583 } 
    },
    {
        ["offsetX"]=587,
        ["textureHeight"] = 256,
        ["textureWidth"] = 310,
        ["offsetY"] = 190,
        ["fileDataIDs"] = { 271584,271565 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 405,
        ["textureWidth"] = 485,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212713,2212714,2212715,2212716 } 
    }
},
[1233] = {
    {
        ["offsetX"]=426,
        ["textureHeight"] = 270,
        ["textureWidth"] = 270,
        ["offsetY"] = 299,
        ["fileDataIDs"] = { 271092,271085,271086,271089 } 
    },
    {
        ["offsetX"]=269,
        ["textureHeight"] = 245,
        ["textureWidth"] = 300,
        ["offsetY"] = 337,
        ["fileDataIDs"] = { 271095,271079 } 
    },
    {
        ["offsetX"]=249,
        ["textureHeight"] = 365,
        ["textureWidth"] = 380,
        ["offsetY"] = 76,
        ["fileDataIDs"] = { 271075,271076,271080,271081 } 
    }
},
[1235] = {
    {
        ["offsetX"]=19,
        ["textureHeight"] = 330,
        ["textureWidth"] = 160,
        ["offsetY"] = 132,
        ["fileDataIDs"] = { 271453,271454 } 
    },
    {
        ["offsetX"]=102,
        ["textureHeight"] = 145,
        ["textureWidth"] = 195,
        ["offsetY"] = 302,
        ["fileDataIDs"] = { 2212669 } 
    },
    {
        ["offsetX"]=653,
        ["textureHeight"] = 175,
        ["textureWidth"] = 200,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 271466 } 
    },
    {
        ["offsetX"]=690,
        ["textureHeight"] = 220,
        ["textureWidth"] = 220,
        ["offsetY"] = 353,
        ["fileDataIDs"] = { 2212676 } 
    },
    {
        ["offsetX"]=504,
        ["textureHeight"] = 340,
        ["textureWidth"] = 220,
        ["offsetY"] = 117,
        ["fileDataIDs"] = { 271470,271477 } 
    },
    {
        ["offsetX"]=390,
        ["textureHeight"] = 250,
        ["textureWidth"] = 235,
        ["offsetY"] = 382,
        ["fileDataIDs"] = { 271449 } 
    },
    {
        ["offsetX"]=539,
        ["textureHeight"] = 230,
        ["textureWidth"] = 250,
        ["offsetY"] = 369,
        ["fileDataIDs"] = { 271455 } 
    },
    {
        ["offsetX"]=243,
        ["textureHeight"] = 285,
        ["textureWidth"] = 255,
        ["offsetY"] = 348,
        ["fileDataIDs"] = { 271448,271456 } 
    },
    {
        ["offsetX"]=55,
        ["textureHeight"] = 250,
        ["textureWidth"] = 275,
        ["offsetY"] = 342,
        ["fileDataIDs"] = { 271444,271483 } 
    },
    {
        ["offsetX"]=631,
        ["textureHeight"] = 280,
        ["textureWidth"] = 315,
        ["offsetY"] = 162,
        ["fileDataIDs"] = { 271471,271461,271450,271451 } 
    },
    {
        ["offsetX"]=85,
        ["textureHeight"] = 300,
        ["textureWidth"] = 350,
        ["offsetY"] = 149,
        ["fileDataIDs"] = { 271473,271463,271467,271464 } 
    },
    {
        ["offsetX"]=298,
        ["textureHeight"] = 420,
        ["textureWidth"] = 360,
        ["offsetY"] = 79,
        ["fileDataIDs"] = { 2212678,2212679,2212680,2212681 } 
    },
    {
        ["offsetX"]=89,
        ["textureHeight"] = 210,
        ["textureWidth"] = 910,
        ["offsetY"] = 31,
        ["fileDataIDs"] = { 271481,271460,271474,271468 } 
    }
},
[1236] = {
    {
        ["offsetX"]=109,
        ["textureHeight"] = 250,
        ["textureWidth"] = 195,
        ["offsetY"] = 370,
        ["fileDataIDs"] = { 252899 } 
    },
    {
        ["offsetX"]=125,
        ["textureHeight"] = 300,
        ["textureWidth"] = 230,
        ["offsetY"] = 12,
        ["fileDataIDs"] = { 252882,252883 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 11,
        ["fileDataIDs"] = { 252884,2212852 } 
    },
    {
        ["offsetX"]=215,
        ["textureHeight"] = 285,
        ["textureWidth"] = 255,
        ["offsetY"] = 348,
        ["fileDataIDs"] = { 252886,252887 } 
    },
    {
        ["offsetX"]=217,
        ["textureHeight"] = 230,
        ["textureWidth"] = 256,
        ["offsetY"] = 203,
        ["fileDataIDs"] = { 252898 } 
    },
    {
        ["offsetX"]=339,
        ["textureHeight"] = 175,
        ["textureWidth"] = 290,
        ["offsetY"] = 11,
        ["fileDataIDs"] = { 2212855,2212856 } 
    },
    {
        ["offsetX"]=309,
        ["textureHeight"] = 358,
        ["textureWidth"] = 295,
        ["offsetY"] = 310,
        ["fileDataIDs"] = { 252862,252863,2212828,2212829 } 
    },
    {
        ["offsetX"]=542,
        ["textureHeight"] = 235,
        ["textureWidth"] = 315,
        ["offsetY"] = 48,
        ["fileDataIDs"] = { 252880,252881 } 
    },
    {
        ["offsetX"]=352,
        ["textureHeight"] = 410,
        ["textureWidth"] = 320,
        ["offsetY"] = 87,
        ["fileDataIDs"] = { 252894,252895,252896,252897 } 
    },
    {
        ["offsetX"]=482,
        ["textureHeight"] = 256,
        ["textureWidth"] = 345,
        ["offsetY"] = 321,
        ["fileDataIDs"] = { 252866,252867 } 
    },
    {
        ["offsetX"]=546,
        ["textureHeight"] = 295,
        ["textureWidth"] = 370,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 252890,252891,252892,252893 } 
    }
},
[1237] = {
    {
        ["offsetX"]=399,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 129,
        ["fileDataIDs"] = { 272334,2212936 } 
    },
    {
        ["offsetX"]=654,
        ["textureHeight"] = 250,
        ["textureWidth"] = 250,
        ["offsetY"] = 161,
        ["fileDataIDs"] = { 272372 } 
    },
    {
        ["offsetX"]=500,
        ["textureHeight"] = 300,
        ["textureWidth"] = 255,
        ["offsetY"] = 215,
        ["fileDataIDs"] = { 2212977,2212978 } 
    },
    {
        ["offsetX"]=277,
        ["textureHeight"] = 256,
        ["textureWidth"] = 275,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272357,272342 } 
    },
    {
        ["offsetX"]=595,
        ["textureHeight"] = 210,
        ["textureWidth"] = 320,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 272347,272371 } 
    },
    {
        ["offsetX"]=83,
        ["textureHeight"] = 195,
        ["textureWidth"] = 340,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 272351,272340 } 
    },
    {
        ["offsetX"]=121,
        ["textureHeight"] = 245,
        ["textureWidth"] = 365,
        ["offsetY"] = 72,
        ["fileDataIDs"] = { 272362,272356 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 350,
        ["textureWidth"] = 365,
        ["offsetY"] = 284,
        ["fileDataIDs"] = { 272364,272348,272358,272359 } 
    },
    {
        ["offsetX"]=187,
        ["textureHeight"] = 290,
        ["textureWidth"] = 430,
        ["offsetY"] = 333,
        ["fileDataIDs"] = { 272344,272354,272350,272339 } 
    },
    {
        ["offsetX"]=484,
        ["textureHeight"] = 255,
        ["textureWidth"] = 465,
        ["offsetY"] = 361,
        ["fileDataIDs"] = { 272369,272363 } 
    },
    {
        ["offsetX"]=133,
        ["textureHeight"] = 275,
        ["textureWidth"] = 535,
        ["offsetY"] = 240,
        ["fileDataIDs"] = { 272335,272343,2212940,2212942,2212943,2212945 } 
    }
},
[1238] = {
    {
        ["offsetX"]=241,
        ["textureHeight"] = 80,
        ["textureWidth"] = 90,
        ["offsetY"] = 92,
        ["fileDataIDs"] = { 2213143 } 
    },
    {
        ["offsetX"]=211,
        ["textureHeight"] = 115,
        ["textureWidth"] = 90,
        ["offsetY"] = 359,
        ["fileDataIDs"] = { 2213164 } 
    },
    {
        ["offsetX"]=299,
        ["textureHeight"] = 95,
        ["textureWidth"] = 95,
        ["offsetY"] = 88,
        ["fileDataIDs"] = { 2213154 } 
    },
    {
        ["offsetX"]=350,
        ["textureHeight"] = 95,
        ["textureWidth"] = 95,
        ["offsetY"] = 335,
        ["fileDataIDs"] = { 2213170 } 
    },
    {
        ["offsetX"]=311,
        ["textureHeight"] = 110,
        ["textureWidth"] = 105,
        ["offsetY"] = 131,
        ["fileDataIDs"] = { 2213161 } 
    },
    {
        ["offsetX"]=387,
        ["textureHeight"] = 125,
        ["textureWidth"] = 105,
        ["offsetY"] = 64,
        ["fileDataIDs"] = { 2213191 } 
    },
    {
        ["offsetX"]=260,
        ["textureHeight"] = 105,
        ["textureWidth"] = 110,
        ["offsetY"] = 132,
        ["fileDataIDs"] = { 2213150 } 
    },
    {
        ["offsetX"]=306,
        ["textureHeight"] = 110,
        ["textureWidth"] = 110,
        ["offsetY"] = 301,
        ["fileDataIDs"] = { 2213171 } 
    },
    {
        ["offsetX"]=371,
        ["textureHeight"] = 140,
        ["textureWidth"] = 110,
        ["offsetY"] = 129,
        ["fileDataIDs"] = { 2213145 } 
    },
    {
        ["offsetX"]=156,
        ["textureHeight"] = 115,
        ["textureWidth"] = 115,
        ["offsetY"] = 42,
        ["fileDataIDs"] = { 2213197 } 
    },
    {
        ["offsetX"]=345,
        ["textureHeight"] = 120,
        ["textureWidth"] = 120,
        ["offsetY"] = 276,
        ["fileDataIDs"] = { 2213148 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 120,
        ["textureWidth"] = 125,
        ["offsetY"] = 493,
        ["fileDataIDs"] = { 2213152 } 
    },
    {
        ["offsetX"]=280,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 368,
        ["fileDataIDs"] = { 2213159 } 
    },
    {
        ["offsetX"]=196,
        ["textureHeight"] = 140,
        ["textureWidth"] = 125,
        ["offsetY"] = 3,
        ["fileDataIDs"] = { 2213173 } 
    },
    {
        ["offsetX"]=331,
        ["textureHeight"] = 125,
        ["textureWidth"] = 128,
        ["offsetY"] = 59,
        ["fileDataIDs"] = { 2213158 } 
    },
    {
        ["offsetX"]=364,
        ["textureHeight"] = 125,
        ["textureWidth"] = 128,
        ["offsetY"] = 231,
        ["fileDataIDs"] = { 2213194 } 
    },
    {
        ["offsetX"]=432,
        ["textureHeight"] = 175,
        ["textureWidth"] = 128,
        ["offsetY"] = 94,
        ["fileDataIDs"] = { 2213162 } 
    },
    {
        ["offsetX"]=269,
        ["textureHeight"] = 110,
        ["textureWidth"] = 140,
        ["offsetY"] = 26,
        ["fileDataIDs"] = { 2213165 } 
    },
    {
        ["offsetX"]=203,
        ["textureHeight"] = 128,
        ["textureWidth"] = 145,
        ["offsetY"] = 433,
        ["fileDataIDs"] = { 2213147 } 
    },
    {
        ["offsetX"]=388,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213156 } 
    },
    {
        ["offsetX"]=194,
        ["textureHeight"] = 175,
        ["textureWidth"] = 165,
        ["offsetY"] = 284,
        ["fileDataIDs"] = { 2213146 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 190,
        ["textureWidth"] = 165,
        ["offsetY"] = 422,
        ["fileDataIDs"] = { 2213192 } 
    },
    {
        ["offsetX"]=284,
        ["textureHeight"] = 90,
        ["textureWidth"] = 170,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213168 } 
    },
    {
        ["offsetX"]=394,
        ["textureHeight"] = 125,
        ["textureWidth"] = 170,
        ["offsetY"] = 212,
        ["fileDataIDs"] = { 2213174 } 
    },
    {
        ["offsetX"]=152,
        ["textureHeight"] = 175,
        ["textureWidth"] = 190,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 2213188 } 
    },
    {
        ["offsetX"]=235,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 2213187 } 
    },
    {
        ["offsetX"]=483,
        ["textureHeight"] = 220,
        ["textureWidth"] = 245,
        ["offsetY"] = 8,
        ["fileDataIDs"] = { 2213196 } 
    }
},
[1239] = {
    {
        ["offsetX"]=724,
        ["textureHeight"] = 365,
        ["textureWidth"] = 215,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 272739,272746 } 
    },
    {
        ["offsetX"]=171,
        ["textureHeight"] = 205,
        ["textureWidth"] = 235,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 272736 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 245,
        ["textureWidth"] = 240,
        ["offsetY"] = 262,
        ["fileDataIDs"] = { 2213206 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 305,
        ["textureWidth"] = 245,
        ["offsetY"] = 140,
        ["fileDataIDs"] = { 272759,272750 } 
    },
    {
        ["offsetX"]=746,
        ["textureHeight"] = 668,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272756,272737,272769 } 
    },
    {
        ["offsetX"]=129,
        ["textureHeight"] = 240,
        ["textureWidth"] = 275,
        ["offsetY"] = 236,
        ["fileDataIDs"] = { 272747,272763 } 
    },
    {
        ["offsetX"]=565,
        ["textureHeight"] = 275,
        ["textureWidth"] = 300,
        ["offsetY"] = 218,
        ["fileDataIDs"] = { 272772,272760,2213215,2213216 } 
    },
    {
        ["offsetX"]=286,
        ["textureHeight"] = 235,
        ["textureWidth"] = 315,
        ["offsetY"] = 110,
        ["fileDataIDs"] = { 272768,272770 } 
    },
    {
        ["offsetX"]=552,
        ["textureHeight"] = 250,
        ["textureWidth"] = 345,
        ["offsetY"] = 378,
        ["fileDataIDs"] = { 272740,272773 } 
    },
    {
        ["offsetX"]=279,
        ["textureHeight"] = 315,
        ["textureWidth"] = 360,
        ["offsetY"] = 237,
        ["fileDataIDs"] = { 272742,272751,272752,272764 } 
    },
    {
        ["offsetX"]=492,
        ["textureHeight"] = 305,
        ["textureWidth"] = 365,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213200,2213202,2213203,2213204 } 
    }
},
[1240] = {
    {
        ["offsetX"]=488,
        ["textureHeight"] = 200,
        ["textureWidth"] = 165,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 273143 } 
    },
    {
        ["offsetX"]=442,
        ["textureHeight"] = 240,
        ["textureWidth"] = 195,
        ["offsetY"] = 241,
        ["fileDataIDs"] = { 273137 } 
    },
    {
        ["offsetX"]=208,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 273142 } 
    },
    {
        ["offsetX"]=524,
        ["textureHeight"] = 240,
        ["textureWidth"] = 200,
        ["offsetY"] = 252,
        ["fileDataIDs"] = { 273125 } 
    },
    {
        ["offsetX"]=387,
        ["textureHeight"] = 215,
        ["textureWidth"] = 210,
        ["offsetY"] = 11,
        ["fileDataIDs"] = { 273145 } 
    },
    {
        ["offsetX"]=307,
        ["textureHeight"] = 215,
        ["textureWidth"] = 215,
        ["offsetY"] = 29,
        ["fileDataIDs"] = { 2212528 } 
    },
    {
        ["offsetX"]=317,
        ["textureHeight"] = 200,
        ["textureWidth"] = 220,
        ["offsetY"] = 331,
        ["fileDataIDs"] = { 273130 } 
    },
    {
        ["offsetX"]=328,
        ["textureHeight"] = 205,
        ["textureWidth"] = 225,
        ["offsetY"] = 148,
        ["fileDataIDs"] = { 273126 } 
    },
    {
        ["offsetX"]=459,
        ["textureHeight"] = 210,
        ["textureWidth"] = 225,
        ["offsetY"] = 105,
        ["fileDataIDs"] = { 273146 } 
    },
    {
        ["offsetX"]=220,
        ["textureHeight"] = 256,
        ["textureWidth"] = 225,
        ["offsetY"] = 102,
        ["fileDataIDs"] = { 273149 } 
    },
    {
        ["offsetX"]=339,
        ["textureHeight"] = 175,
        ["textureWidth"] = 256,
        ["offsetY"] = 418,
        ["fileDataIDs"] = { 273124 } 
    },
    {
        ["offsetX"]=205,
        ["textureHeight"] = 190,
        ["textureWidth"] = 280,
        ["offsetY"] = 467,
        ["fileDataIDs"] = { 273141,2212527 } 
    },
    {
        ["offsetX"]=523,
        ["textureHeight"] = 235,
        ["textureWidth"] = 288,
        ["offsetY"] = 377,
        ["fileDataIDs"] = { 273131,273134 } 
    },
    {
        ["offsetX"]=204,
        ["textureHeight"] = 210,
        ["textureWidth"] = 305,
        ["offsetY"] = 260,
        ["fileDataIDs"] = { 273129,273133 } 
    }
},
[1243] = {
    {
        ["offsetX"]=13,
        ["textureHeight"] = 128,
        ["textureWidth"] = 175,
        ["offsetY"] = 314,
        ["fileDataIDs"] = { 273156 } 
    },
    {
        ["offsetX"]=456,
        ["textureHeight"] = 240,
        ["textureWidth"] = 185,
        ["offsetY"] = 125,
        ["fileDataIDs"] = { 2212531 } 
    },
    {
        ["offsetX"]=628,
        ["textureHeight"] = 160,
        ["textureWidth"] = 190,
        ["offsetY"] = 176,
        ["fileDataIDs"] = { 273181 } 
    },
    {
        ["offsetX"]=247,
        ["textureHeight"] = 185,
        ["textureWidth"] = 195,
        ["offsetY"] = 205,
        ["fileDataIDs"] = { 273155 } 
    },
    {
        ["offsetX"]=349,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 115,
        ["fileDataIDs"] = { 273173 } 
    },
    {
        ["offsetX"]=237,
        ["textureHeight"] = 240,
        ["textureWidth"] = 200,
        ["offsetY"] = 41,
        ["fileDataIDs"] = { 2212533 } 
    },
    {
        ["offsetX"]=401,
        ["textureHeight"] = 180,
        ["textureWidth"] = 205,
        ["offsetY"] = 21,
        ["fileDataIDs"] = { 273164 } 
    },
    {
        ["offsetX"]=527,
        ["textureHeight"] = 245,
        ["textureWidth"] = 205,
        ["offsetY"] = 264,
        ["fileDataIDs"] = { 273177 } 
    },
    {
        ["offsetX"]=347,
        ["textureHeight"] = 185,
        ["textureWidth"] = 225,
        ["offsetY"] = 218,
        ["fileDataIDs"] = { 273159 } 
    },
    {
        ["offsetX"]=89,
        ["textureHeight"] = 190,
        ["textureWidth"] = 225,
        ["offsetY"] = 142,
        ["fileDataIDs"] = { 273171 } 
    },
    {
        ["offsetX"]=470,
        ["textureHeight"] = 190,
        ["textureWidth"] = 230,
        ["offsetY"] = 371,
        ["fileDataIDs"] = { 273174 } 
    },
    {
        ["offsetX"]=77,
        ["textureHeight"] = 175,
        ["textureWidth"] = 240,
        ["offsetY"] = 245,
        ["fileDataIDs"] = { 273163 } 
    },
    {
        ["offsetX"]=507,
        ["textureHeight"] = 250,
        ["textureWidth"] = 256,
        ["offsetY"] = 115,
        ["fileDataIDs"] = { 2212535 } 
    },
    {
        ["offsetX"]=92,
        ["textureHeight"] = 240,
        ["textureWidth"] = 300,
        ["offsetY"] = 82,
        ["fileDataIDs"] = { 273178,273167 } 
    },
    {
        ["offsetX"]=611,
        ["textureHeight"] = 360,
        ["textureWidth"] = 350,
        ["offsetY"] = 230,
        ["fileDataIDs"] = { 2213613,2213614,2212532,2212534 } 
    }
},
[1244] = {
    {
        ["offsetX"]=494,
        ["textureHeight"] = 100,
        ["textureWidth"] = 128,
        ["offsetY"] = 548,
        ["fileDataIDs"] = { 2213328 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 190,
        ["textureWidth"] = 128,
        ["offsetY"] = 313,
        ["fileDataIDs"] = { 272807 } 
    },
    {
        ["offsetX"]=382,
        ["textureHeight"] = 210,
        ["textureWidth"] = 160,
        ["offsetY"] = 281,
        ["fileDataIDs"] = { 272826 } 
    },
    {
        ["offsetX"]=272,
        ["textureHeight"] = 240,
        ["textureWidth"] = 170,
        ["offsetY"] = 127,
        ["fileDataIDs"] = { 272830 } 
    },
    {
        ["offsetX"]=377,
        ["textureHeight"] = 256,
        ["textureWidth"] = 180,
        ["offsetY"] = 93,
        ["fileDataIDs"] = { 272822 } 
    },
    {
        ["offsetX"]=368,
        ["textureHeight"] = 128,
        ["textureWidth"] = 185,
        ["offsetY"] = 443,
        ["fileDataIDs"] = { 272814 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 128,
        ["textureWidth"] = 190,
        ["offsetY"] = 323,
        ["fileDataIDs"] = { 2213323 } 
    },
    {
        ["offsetX"]=561,
        ["textureHeight"] = 200,
        ["textureWidth"] = 200,
        ["offsetY"] = 292,
        ["fileDataIDs"] = { 272815 } 
    },
    {
        ["offsetX"]=491,
        ["textureHeight"] = 225,
        ["textureWidth"] = 225,
        ["offsetY"] = 153,
        ["fileDataIDs"] = { 272811 } 
    },
    {
        ["offsetX"]=436,
        ["textureHeight"] = 185,
        ["textureWidth"] = 256,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 272810 } 
    },
    {
        ["offsetX"]=101,
        ["textureHeight"] = 256,
        ["textureWidth"] = 315,
        ["offsetY"] = 247,
        ["fileDataIDs"] = { 272806,272812 } 
    }
},
[1247] = {
    {
        ["offsetX"]=318,
        ["textureHeight"] = 215,
        ["textureWidth"] = 150,
        ["offsetY"] = 162,
        ["fileDataIDs"] = { 769206 } 
    },
    {
        ["offsetX"]=468,
        ["textureHeight"] = 195,
        ["textureWidth"] = 170,
        ["offsetY"] = 85,
        ["fileDataIDs"] = { 769211 } 
    },
    {
        ["offsetX"]=329,
        ["textureHeight"] = 158,
        ["textureWidth"] = 175,
        ["offsetY"] = 510,
        ["fileDataIDs"] = { 271044 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 183,
        ["textureWidth"] = 175,
        ["offsetY"] = 485,
        ["fileDataIDs"] = { 769210 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 195,
        ["textureWidth"] = 180,
        ["offsetY"] = 181,
        ["fileDataIDs"] = { 769207 } 
    },
    {
        ["offsetX"]=324,
        ["textureHeight"] = 205,
        ["textureWidth"] = 190,
        ["offsetY"] = 306,
        ["fileDataIDs"] = { 271045 } 
    },
    {
        ["offsetX"]=510,
        ["textureHeight"] = 215,
        ["textureWidth"] = 195,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271043 } 
    },
    {
        ["offsetX"]=305,
        ["textureHeight"] = 170,
        ["textureWidth"] = 200,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 769209 } 
    },
    {
        ["offsetX"]=375,
        ["textureHeight"] = 190,
        ["textureWidth"] = 230,
        ["offsetY"] = 94,
        ["fileDataIDs"] = { 769208 } 
    }
},
[1248] = {
    {
        ["offsetX"]=131,
        ["textureHeight"] = 195,
        ["textureWidth"] = 128,
        ["offsetY"] = 137,
        ["fileDataIDs"] = { 270380 } 
    },
    {
        ["offsetX"]=856,
        ["textureHeight"] = 200,
        ["textureWidth"] = 146,
        ["offsetY"] = 151,
        ["fileDataIDs"] = { 270387 } 
    },
    {
        ["offsetX"]=260,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 373,
        ["fileDataIDs"] = { 270398 } 
    },
    {
        ["offsetX"]=189,
        ["textureHeight"] = 175,
        ["textureWidth"] = 165,
        ["offsetY"] = 324,
        ["fileDataIDs"] = { 2212540 } 
    },
    {
        ["offsetX"]=520,
        ["textureHeight"] = 245,
        ["textureWidth"] = 180,
        ["offsetY"] = 238,
        ["fileDataIDs"] = { 270402 } 
    },
    {
        ["offsetX"]=796,
        ["textureHeight"] = 160,
        ["textureWidth"] = 200,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 270390 } 
    },
    {
        ["offsetX"]=392,
        ["textureHeight"] = 205,
        ["textureWidth"] = 200,
        ["offsetY"] = 218,
        ["fileDataIDs"] = { 2212541 } 
    },
    {
        ["offsetX"]=272,
        ["textureHeight"] = 185,
        ["textureWidth"] = 205,
        ["offsetY"] = 251,
        ["fileDataIDs"] = { 270386 } 
    },
    {
        ["offsetX"]=463,
        ["textureHeight"] = 185,
        ["textureWidth"] = 210,
        ["offsetY"] = 141,
        ["fileDataIDs"] = { 270400 } 
    },
    {
        ["offsetX"]=205,
        ["textureHeight"] = 305,
        ["textureWidth"] = 215,
        ["offsetY"] = 38,
        ["fileDataIDs"] = { 2212542,2212543 } 
    },
    {
        ["offsetX"]=104,
        ["textureHeight"] = 195,
        ["textureWidth"] = 220,
        ["offsetY"] = 259,
        ["fileDataIDs"] = { 2212548 } 
    },
    {
        ["offsetX"]=597,
        ["textureHeight"] = 255,
        ["textureWidth"] = 225,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 270401 } 
    },
    {
        ["offsetX"]=547,
        ["textureHeight"] = 205,
        ["textureWidth"] = 235,
        ["offsetY"] = 426,
        ["fileDataIDs"] = { 270375 } 
    },
    {
        ["offsetX"]=19,
        ["textureHeight"] = 245,
        ["textureWidth"] = 245,
        ["offsetY"] = 28,
        ["fileDataIDs"] = { 270376 } 
    },
    {
        ["offsetX"]=713,
        ["textureHeight"] = 255,
        ["textureWidth"] = 245,
        ["offsetY"] = 344,
        ["fileDataIDs"] = { 270405 } 
    },
    {
        ["offsetX"]=203,
        ["textureHeight"] = 195,
        ["textureWidth"] = 255,
        ["offsetY"] = 158,
        ["fileDataIDs"] = { 270389 } 
    },
    {
        ["offsetX"]=356,
        ["textureHeight"] = 240,
        ["textureWidth"] = 275,
        ["offsetY"] = 347,
        ["fileDataIDs"] = { 2212544,2212545 } 
    },
    {
        ["offsetX"]=694,
        ["textureHeight"] = 185,
        ["textureWidth"] = 285,
        ["offsetY"] = 225,
        ["fileDataIDs"] = { 270388,2212547 } 
    }
},
[1249] = {
    {
        ["offsetX"]=31,
        ["textureHeight"] = 190,
        ["textureWidth"] = 190,
        ["offsetY"] = 155,
        ["fileDataIDs"] = { 272968 } 
    },
    {
        ["offsetX"]=259,
        ["textureHeight"] = 195,
        ["textureWidth"] = 205,
        ["offsetY"] = 131,
        ["fileDataIDs"] = { 272962 } 
    },
    {
        ["offsetX"]=205,
        ["textureHeight"] = 180,
        ["textureWidth"] = 210,
        ["offsetY"] = 70,
        ["fileDataIDs"] = { 272963 } 
    },
    {
        ["offsetX"]=357,
        ["textureHeight"] = 190,
        ["textureWidth"] = 210,
        ["offsetY"] = 264,
        ["fileDataIDs"] = { 272954 } 
    },
    {
        ["offsetX"]=391,
        ["textureHeight"] = 195,
        ["textureWidth"] = 210,
        ["offsetY"] = 192,
        ["fileDataIDs"] = { 2213363 } 
    },
    {
        ["offsetX"]=492,
        ["textureHeight"] = 220,
        ["textureWidth"] = 240,
        ["offsetY"] = 250,
        ["fileDataIDs"] = { 2213395 } 
    },
    {
        ["offsetX"]=179,
        ["textureHeight"] = 240,
        ["textureWidth"] = 250,
        ["offsetY"] = 200,
        ["fileDataIDs"] = { 2213369 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 310,
        ["textureWidth"] = 305,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213348,2213349,2213351,2213352 } 
    },
    {
        ["offsetX"]=610,
        ["textureHeight"] = 365,
        ["textureWidth"] = 320,
        ["offsetY"] = 300,
        ["fileDataIDs"] = { 2213371,2213372,2213374,2213375 } 
    }
},
[1250] = {
    {
        ["offsetX"]=663,
        ["textureHeight"] = 86,
        ["textureWidth"] = 125,
        ["offsetY"] = 582,
        ["fileDataIDs"] = { 272650 } 
    },
    {
        ["offsetX"]=475,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 433,
        ["fileDataIDs"] = { 2213093 } 
    },
    {
        ["offsetX"]=572,
        ["textureHeight"] = 107,
        ["textureWidth"] = 145,
        ["offsetY"] = 561,
        ["fileDataIDs"] = { 272628 } 
    },
    {
        ["offsetX"]=389,
        ["textureHeight"] = 150,
        ["textureWidth"] = 150,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 272646 } 
    },
    {
        ["offsetX"]=718,
        ["textureHeight"] = 97,
        ["textureWidth"] = 190,
        ["offsetY"] = 571,
        ["fileDataIDs"] = { 2213087 } 
    },
    {
        ["offsetX"]=390,
        ["textureHeight"] = 215,
        ["textureWidth"] = 200,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 272624 } 
    },
    {
        ["offsetX"]=668,
        ["textureHeight"] = 120,
        ["textureWidth"] = 225,
        ["offsetY"] = 515,
        ["fileDataIDs"] = { 2213088 } 
    },
    {
        ["offsetX"]=210,
        ["textureHeight"] = 355,
        ["textureWidth"] = 230,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 272633,272647 } 
    },
    {
        ["offsetX"]=247,
        ["textureHeight"] = 205,
        ["textureWidth"] = 270,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272632,272641 } 
    },
    {
        ["offsetX"]=457,
        ["textureHeight"] = 355,
        ["textureWidth"] = 288,
        ["offsetY"] = 282,
        ["fileDataIDs"] = { 272648,272634,272635,272623 } 
    },
    {
        ["offsetX"]=553,
        ["textureHeight"] = 275,
        ["textureWidth"] = 320,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 272630,272649,272642,272636 } 
    }
},
[1251] = {
    {
        ["offsetX"]=241,
        ["textureHeight"] = 100,
        ["textureWidth"] = 100,
        ["offsetY"] = 6,
        ["fileDataIDs"] = { 2212638 } 
    },
    {
        ["offsetX"]=555,
        ["textureHeight"] = 160,
        ["textureWidth"] = 170,
        ["offsetY"] = 181,
        ["fileDataIDs"] = { 2212635 } 
    },
    {
        ["offsetX"]=447,
        ["textureHeight"] = 220,
        ["textureWidth"] = 190,
        ["offsetY"] = 102,
        ["fileDataIDs"] = { 271111 } 
    },
    {
        ["offsetX"]=293,
        ["textureHeight"] = 242,
        ["textureWidth"] = 195,
        ["offsetY"] = 426,
        ["fileDataIDs"] = { 271122 } 
    },
    {
        ["offsetX"]=554,
        ["textureHeight"] = 250,
        ["textureWidth"] = 200,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271114 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 145,
        ["textureWidth"] = 205,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271126 } 
    },
    {
        ["offsetX"]=690,
        ["textureHeight"] = 195,
        ["textureWidth"] = 205,
        ["offsetY"] = 444,
        ["fileDataIDs"] = { 271105 } 
    },
    {
        ["offsetX"]=311,
        ["textureHeight"] = 250,
        ["textureWidth"] = 205,
        ["offsetY"] = 61,
        ["fileDataIDs"] = { 2212632 } 
    },
    {
        ["offsetX"]=590,
        ["textureHeight"] = 285,
        ["textureWidth"] = 205,
        ["offsetY"] = 365,
        ["fileDataIDs"] = { 2212636,2212637 } 
    },
    {
        ["offsetX"]=607,
        ["textureHeight"] = 220,
        ["textureWidth"] = 220,
        ["offsetY"] = 215,
        ["fileDataIDs"] = { 2212634 } 
    },
    {
        ["offsetX"]=167,
        ["textureHeight"] = 230,
        ["textureWidth"] = 230,
        ["offsetY"] = 389,
        ["fileDataIDs"] = { 271125 } 
    },
    {
        ["offsetX"]=212,
        ["textureHeight"] = 285,
        ["textureWidth"] = 245,
        ["offsetY"] = 215,
        ["fileDataIDs"] = { 271106,271129 } 
    },
    {
        ["offsetX"]=387,
        ["textureHeight"] = 250,
        ["textureWidth"] = 275,
        ["offsetY"] = 244,
        ["fileDataIDs"] = { 271127,2212633 } 
    },
    {
        ["offsetX"]=625,
        ["textureHeight"] = 245,
        ["textureWidth"] = 285,
        ["offsetY"] = 33,
        ["fileDataIDs"] = { 271104,271124 } 
    },
    {
        ["offsetX"]=399,
        ["textureHeight"] = 280,
        ["textureWidth"] = 285,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 271108,271112,271113,271109 } 
    }
},
[1252] = {
    {
        ["offsetX"]=493,
        ["textureHeight"] = 110,
        ["textureWidth"] = 110,
        ["offsetY"] = 70,
        ["fileDataIDs"] = { 2212732 } 
    },
    {
        ["offsetX"]=478,
        ["textureHeight"] = 170,
        ["textureWidth"] = 110,
        ["offsetY"] = 386,
        ["fileDataIDs"] = { 2212728 } 
    },
    {
        ["offsetX"]=486,
        ["textureHeight"] = 115,
        ["textureWidth"] = 115,
        ["offsetY"] = 329,
        ["fileDataIDs"] = { 2212726 } 
    },
    {
        ["offsetX"]=623,
        ["textureHeight"] = 195,
        ["textureWidth"] = 120,
        ["offsetY"] = 167,
        ["fileDataIDs"] = { 2212729 } 
    },
    {
        ["offsetX"]=690,
        ["textureHeight"] = 165,
        ["textureWidth"] = 140,
        ["offsetY"] = 141,
        ["fileDataIDs"] = { 271696 } 
    },
    {
        ["offsetX"]=404,
        ["textureHeight"] = 320,
        ["textureWidth"] = 145,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 271700,271682 } 
    },
    {
        ["offsetX"]=454,
        ["textureHeight"] = 125,
        ["textureWidth"] = 150,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212721 } 
    },
    {
        ["offsetX"]=689,
        ["textureHeight"] = 160,
        ["textureWidth"] = 155,
        ["offsetY"] = 233,
        ["fileDataIDs"] = { 271675 } 
    },
    {
        ["offsetX"]=208,
        ["textureHeight"] = 180,
        ["textureWidth"] = 180,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 2212734 } 
    },
    {
        ["offsetX"]=305,
        ["textureHeight"] = 155,
        ["textureWidth"] = 190,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212733 } 
    },
    {
        ["offsetX"]=540,
        ["textureHeight"] = 250,
        ["textureWidth"] = 190,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 271699 } 
    },
    {
        ["offsetX"]=192,
        ["textureHeight"] = 293,
        ["textureWidth"] = 215,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 2212730,2212731 } 
    },
    {
        ["offsetX"]=751,
        ["textureHeight"] = 180,
        ["textureWidth"] = 225,
        ["offsetY"] = 198,
        ["fileDataIDs"] = { 271680 } 
    },
    {
        ["offsetX"]=454,
        ["textureHeight"] = 195,
        ["textureWidth"] = 230,
        ["offsetY"] = 201,
        ["fileDataIDs"] = { 271687 } 
    },
    {
        ["offsetX"]=618,
        ["textureHeight"] = 220,
        ["textureWidth"] = 240,
        ["offsetY"] = 298,
        ["fileDataIDs"] = { 2212735 } 
    },
    {
        ["offsetX"]=319,
        ["textureHeight"] = 245,
        ["textureWidth"] = 285,
        ["offsetY"] = 75,
        ["fileDataIDs"] = { 271705,271686 } 
    }
},
[1253] = {
    {
        ["offsetX"]=660,
        ["textureHeight"] = 195,
        ["textureWidth"] = 200,
        ["offsetY"] = 21,
        ["fileDataIDs"] = { 271494 } 
    },
    {
        ["offsetX"]=534,
        ["textureHeight"] = 205,
        ["textureWidth"] = 230,
        ["offsetY"] = 224,
        ["fileDataIDs"] = { 271500 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 315,
        ["textureWidth"] = 250,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271507,271504 } 
    },
    {
        ["offsetX"]=257,
        ["textureHeight"] = 250,
        ["textureWidth"] = 255,
        ["offsetY"] = 313,
        ["fileDataIDs"] = { 2212689 } 
    },
    {
        ["offsetX"]=230,
        ["textureHeight"] = 270,
        ["textureWidth"] = 280,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212685,2212686,2212687,2212688 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 240,
        ["textureWidth"] = 285,
        ["offsetY"] = 381,
        ["fileDataIDs"] = { 271503,271509 } 
    },
    {
        ["offsetX"]=239,
        ["textureHeight"] = 255,
        ["textureWidth"] = 400,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 2212683,2212684 } 
    }
},
[1254] = {
    {
        ["offsetX"]=611,
        ["textureHeight"] = 140,
        ["textureWidth"] = 110,
        ["offsetY"] = 147,
        ["fileDataIDs"] = { 2213315 } 
    },
    {
        ["offsetX"]=473,
        ["textureHeight"] = 180,
        ["textureWidth"] = 110,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 272800 } 
    },
    {
        ["offsetX"]=533,
        ["textureHeight"] = 135,
        ["textureWidth"] = 120,
        ["offsetY"] = 104,
        ["fileDataIDs"] = { 2213275 } 
    },
    {
        ["offsetX"]=291,
        ["textureHeight"] = 160,
        ["textureWidth"] = 150,
        ["offsetY"] = 434,
        ["fileDataIDs"] = { 2213311 } 
    },
    {
        ["offsetX"]=561,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 272789 } 
    },
    {
        ["offsetX"]=592,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 75,
        ["fileDataIDs"] = { 2213281 } 
    },
    {
        ["offsetX"]=395,
        ["textureHeight"] = 150,
        ["textureWidth"] = 160,
        ["offsetY"] = 346,
        ["fileDataIDs"] = { 272798 } 
    },
    {
        ["offsetX"]=629,
        ["textureHeight"] = 190,
        ["textureWidth"] = 160,
        ["offsetY"] = 220,
        ["fileDataIDs"] = { 2213273 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 180,
        ["textureWidth"] = 165,
        ["offsetY"] = 168,
        ["fileDataIDs"] = { 2213313 } 
    },
    {
        ["offsetX"]=421,
        ["textureHeight"] = 165,
        ["textureWidth"] = 175,
        ["offsetY"] = 91,
        ["fileDataIDs"] = { 272774 } 
    },
    {
        ["offsetX"]=252,
        ["textureHeight"] = 200,
        ["textureWidth"] = 180,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 272792 } 
    },
    {
        ["offsetX"]=203,
        ["textureHeight"] = 250,
        ["textureWidth"] = 185,
        ["offsetY"] = 286,
        ["fileDataIDs"] = { 272781 } 
    },
    {
        ["offsetX"]=299,
        ["textureHeight"] = 175,
        ["textureWidth"] = 195,
        ["offsetY"] = 100,
        ["fileDataIDs"] = { 272776 } 
    },
    {
        ["offsetX"]=323,
        ["textureHeight"] = 210,
        ["textureWidth"] = 195,
        ["offsetY"] = 359,
        ["fileDataIDs"] = { 272784 } 
    },
    {
        ["offsetX"]=325,
        ["textureHeight"] = 145,
        ["textureWidth"] = 205,
        ["offsetY"] = 289,
        ["fileDataIDs"] = { 272782 } 
    },
    {
        ["offsetX"]=445,
        ["textureHeight"] = 157,
        ["textureWidth"] = 205,
        ["offsetY"] = 511,
        ["fileDataIDs"] = { 272801 } 
    },
    {
        ["offsetX"]=254,
        ["textureHeight"] = 175,
        ["textureWidth"] = 210,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272788 } 
    },
    {
        ["offsetX"]=499,
        ["textureHeight"] = 175,
        ["textureWidth"] = 215,
        ["offsetY"] = 293,
        ["fileDataIDs"] = { 272795 } 
    },
    {
        ["offsetX"]=363,
        ["textureHeight"] = 180,
        ["textureWidth"] = 215,
        ["offsetY"] = 194,
        ["fileDataIDs"] = { 272799 } 
    },
    {
        ["offsetX"]=449,
        ["textureHeight"] = 210,
        ["textureWidth"] = 220,
        ["offsetY"] = 372,
        ["fileDataIDs"] = { 272805 } 
    }
},
[1259] = {
    {
        ["offsetX"]=818,
        ["textureHeight"] = 155,
        ["textureWidth"] = 120,
        ["offsetY"] = 107,
        ["fileDataIDs"] = { 270434 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 215,
        ["textureWidth"] = 145,
        ["offsetY"] = 95,
        ["fileDataIDs"] = { 2212573 } 
    },
    {
        ["offsetX"]=404,
        ["textureHeight"] = 210,
        ["textureWidth"] = 160,
        ["offsetY"] = 194,
        ["fileDataIDs"] = { 270412 } 
    },
    {
        ["offsetX"]=681,
        ["textureHeight"] = 200,
        ["textureWidth"] = 190,
        ["offsetY"] = 153,
        ["fileDataIDs"] = { 2212567 } 
    },
    {
        ["offsetX"]=77,
        ["textureHeight"] = 150,
        ["textureWidth"] = 200,
        ["offsetY"] = 331,
        ["fileDataIDs"] = { 2212555 } 
    },
    {
        ["offsetX"]=84,
        ["textureHeight"] = 175,
        ["textureWidth"] = 215,
        ["offsetY"] = 229,
        ["fileDataIDs"] = { 2212574 } 
    },
    {
        ["offsetX"]=191,
        ["textureHeight"] = 255,
        ["textureWidth"] = 220,
        ["offsetY"] = 369,
        ["fileDataIDs"] = { 2212554 } 
    },
    {
        ["offsetX"]=35,
        ["textureHeight"] = 180,
        ["textureWidth"] = 225,
        ["offsetY"] = 422,
        ["fileDataIDs"] = { 2212564 } 
    },
    {
        ["offsetX"]=478,
        ["textureHeight"] = 140,
        ["textureWidth"] = 235,
        ["offsetY"] = 44,
        ["fileDataIDs"] = { 2212560 } 
    },
    {
        ["offsetX"]=250,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 106,
        ["fileDataIDs"] = { 2212571,2212572 } 
    },
    {
        ["offsetX"]=552,
        ["textureHeight"] = 125,
        ["textureWidth"] = 240,
        ["offsetY"] = 499,
        ["fileDataIDs"] = { 270410 } 
    },
    {
        ["offsetX"]=499,
        ["textureHeight"] = 155,
        ["textureWidth"] = 240,
        ["offsetY"] = 119,
        ["fileDataIDs"] = { 2212568 } 
    },
    {
        ["offsetX"]=644,
        ["textureHeight"] = 185,
        ["textureWidth"] = 245,
        ["offsetY"] = 40,
        ["fileDataIDs"] = { 270432 } 
    },
    {
        ["offsetX"]=238,
        ["textureHeight"] = 280,
        ["textureWidth"] = 265,
        ["offsetY"] = 221,
        ["fileDataIDs"] = { 270414,2212561,2212562,2212563 } 
    },
    {
        ["offsetX"]=479,
        ["textureHeight"] = 300,
        ["textureWidth"] = 270,
        ["offsetY"] = 201,
        ["fileDataIDs"] = { 2212550,2212551,2212552,2212553 } 
    },
    {
        ["offsetX"]=296,
        ["textureHeight"] = 200,
        ["textureWidth"] = 315,
        ["offsetY"] = 429,
        ["fileDataIDs"] = { 270409,2212559 } 
    },
    {
        ["offsetX"]=389,
        ["textureHeight"] = 220,
        ["textureWidth"] = 370,
        ["offsetY"] = 353,
        ["fileDataIDs"] = { 2212565,2212566 } 
    },
    {
        ["offsetX"]=396,
        ["textureHeight"] = 128,
        ["textureWidth"] = 395,
        ["offsetY"] = 540,
        ["fileDataIDs"] = { 2212569,2212570 } 
    },
    {
        ["offsetX"]=366,
        ["textureHeight"] = 170,
        ["textureWidth"] = 570,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212556,2212557,2212558 } 
    }
},
[1260] = {
    {
        ["offsetX"]=496,
        ["textureHeight"] = 159,
        ["textureWidth"] = 145,
        ["offsetY"] = 509,
        ["fileDataIDs"] = { 271657 } 
    },
    {
        ["offsetX"]=548,
        ["textureHeight"] = 145,
        ["textureWidth"] = 160,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 271653 } 
    },
    {
        ["offsetX"]=332,
        ["textureHeight"] = 155,
        ["textureWidth"] = 165,
        ["offsetY"] = 465,
        ["fileDataIDs"] = { 271663 } 
    },
    {
        ["offsetX"]=408,
        ["textureHeight"] = 135,
        ["textureWidth"] = 175,
        ["offsetY"] = 533,
        ["fileDataIDs"] = { 271658 } 
    },
    {
        ["offsetX"]=405,
        ["textureHeight"] = 160,
        ["textureWidth"] = 185,
        ["offsetY"] = 429,
        ["fileDataIDs"] = { 271659 } 
    },
    {
        ["offsetX"]=330,
        ["textureHeight"] = 170,
        ["textureWidth"] = 195,
        ["offsetY"] = 29,
        ["fileDataIDs"] = { 271652 } 
    },
    {
        ["offsetX"]=420,
        ["textureHeight"] = 215,
        ["textureWidth"] = 215,
        ["offsetY"] = 54,
        ["fileDataIDs"] = { 271673 } 
    },
    {
        ["offsetX"]=292,
        ["textureHeight"] = 145,
        ["textureWidth"] = 235,
        ["offsetY"] = 263,
        ["fileDataIDs"] = { 271666 } 
    },
    {
        ["offsetX"]=297,
        ["textureHeight"] = 155,
        ["textureWidth"] = 235,
        ["offsetY"] = 381,
        ["fileDataIDs"] = { 271664 } 
    },
    {
        ["offsetX"]=307,
        ["textureHeight"] = 200,
        ["textureWidth"] = 235,
        ["offsetY"] = 123,
        ["fileDataIDs"] = { 271665 } 
    },
    {
        ["offsetX"]=483,
        ["textureHeight"] = 145,
        ["textureWidth"] = 240,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271660 } 
    },
    {
        ["offsetX"]=271,
        ["textureHeight"] = 128,
        ["textureWidth"] = 245,
        ["offsetY"] = 331,
        ["fileDataIDs"] = { 271669 } 
    }
},
[1261] = {
    {
        ["offsetX"]=582,
        ["textureHeight"] = 285,
        ["textureWidth"] = 285,
        ["offsetY"] = 67,
        ["fileDataIDs"] = { 273051,2213483,2213484,2213486 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 270,
        ["textureWidth"] = 295,
        ["offsetY"] = 178,
        ["fileDataIDs"] = { 273042,273065,273050,273036 } 
    },
    {
        ["offsetX"]=560,
        ["textureHeight"] = 355,
        ["textureWidth"] = 310,
        ["offsetY"] = 240,
        ["fileDataIDs"] = { 273072,273039,273037,273063 } 
    },
    {
        ["offsetX"]=121,
        ["textureHeight"] = 345,
        ["textureWidth"] = 315,
        ["offsetY"] = 151,
        ["fileDataIDs"] = { 273043,273075,273069,273061 } 
    },
    {
        ["offsetX"]=158,
        ["textureHeight"] = 285,
        ["textureWidth"] = 345,
        ["offsetY"] = 368,
        ["fileDataIDs"] = { 273046,273053,273071,273047 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 285,
        ["textureWidth"] = 345,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 273059,273066,273073,273054 } 
    },
    {
        ["offsetX"]=160,
        ["textureHeight"] = 265,
        ["textureWidth"] = 570,
        ["offsetY"] = 6,
        ["fileDataIDs"] = { 273052,273062,273057,273058,2213490,2213491 } 
    }
},
[1263] = {
    {
        ["offsetX"]=244,
        ["textureHeight"] = 510,
        ["textureWidth"] = 555,
        ["offsetY"] = 89,
        ["fileDataIDs"] = { 252844,252845,252846,252847,2212870,2212872 } 
    }
},
[1264] = {
    {
        ["offsetX"]=116,
        ["textureHeight"] = 256,
        ["textureWidth"] = 288,
        ["offsetY"] = 413,
        ["fileDataIDs"] = { 272564,272553 } 
    },
    {
        ["offsetX"]=344,
        ["textureHeight"] = 256,
        ["textureWidth"] = 320,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 272573,272545 } 
    },
    {
        ["offsetX"]=104,
        ["textureHeight"] = 289,
        ["textureWidth"] = 320,
        ["offsetY"] = 24,
        ["fileDataIDs"] = { 272581,272562,2213052,2213053 } 
    },
    {
        ["offsetX"]=500,
        ["textureHeight"] = 384,
        ["textureWidth"] = 384,
        ["offsetY"] = 65,
        ["fileDataIDs"] = { 272580,272544,2213048,2213049 } 
    },
    {
        ["offsetX"]=97,
        ["textureHeight"] = 512,
        ["textureWidth"] = 384,
        ["offsetY"] = 144,
        ["fileDataIDs"] = { 272559,272543,272574,272575 } 
    },
    {
        ["offsetX"]=265,
        ["textureHeight"] = 320,
        ["textureWidth"] = 512,
        ["offsetY"] = 12,
        ["fileDataIDs"] = { 272565,272566,272577,272546 } 
    },
    {
        ["offsetX"]=245,
        ["textureHeight"] = 384,
        ["textureWidth"] = 512,
        ["offsetY"] = 285,
        ["fileDataIDs"] = { 272567,272547,272555,272548 } 
    }
},
[1266] = {
    {
        ["offsetX"]=611,
        ["textureHeight"] = 165,
        ["textureWidth"] = 125,
        ["offsetY"] = 242,
        ["fileDataIDs"] = { 273206 } 
    },
    {
        ["offsetX"]=617,
        ["textureHeight"] = 125,
        ["textureWidth"] = 145,
        ["offsetY"] = 158,
        ["fileDataIDs"] = { 273200 } 
    },
    {
        ["offsetX"]=593,
        ["textureHeight"] = 140,
        ["textureWidth"] = 165,
        ["offsetY"] = 340,
        ["fileDataIDs"] = { 273199 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 200,
        ["textureWidth"] = 165,
        ["offsetY"] = 107,
        ["fileDataIDs"] = { 273191 } 
    },
    {
        ["offsetX"]=555,
        ["textureHeight"] = 185,
        ["textureWidth"] = 175,
        ["offsetY"] = 27,
        ["fileDataIDs"] = { 273203 } 
    },
    {
        ["offsetX"]=392,
        ["textureHeight"] = 160,
        ["textureWidth"] = 185,
        ["offsetY"] = 137,
        ["fileDataIDs"] = { 273207 } 
    },
    {
        ["offsetX"]=493,
        ["textureHeight"] = 180,
        ["textureWidth"] = 185,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 273185 } 
    },
    {
        ["offsetX"]=523,
        ["textureHeight"] = 160,
        ["textureWidth"] = 200,
        ["offsetY"] = 376,
        ["fileDataIDs"] = { 273198 } 
    },
    {
        ["offsetX"]=401,
        ["textureHeight"] = 185,
        ["textureWidth"] = 215,
        ["offsetY"] = 198,
        ["fileDataIDs"] = { 273192 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 120,
        ["textureWidth"] = 230,
        ["offsetY"] = 243,
        ["fileDataIDs"] = { 273187 } 
    },
    {
        ["offsetX"]=222,
        ["textureHeight"] = 140,
        ["textureWidth"] = 240,
        ["offsetY"] = 172,
        ["fileDataIDs"] = { 273202 } 
    },
    {
        ["offsetX"]=368,
        ["textureHeight"] = 180,
        ["textureWidth"] = 250,
        ["offsetY"] = 7,
        ["fileDataIDs"] = { 273184 } 
    },
    {
        ["offsetX"]=447,
        ["textureHeight"] = 205,
        ["textureWidth"] = 255,
        ["offsetY"] = 441,
        ["fileDataIDs"] = { 2213650 } 
    }
},
[1273] = {
    {
        ["offsetX"]=399,
        ["textureHeight"] = 290,
        ["textureWidth"] = 235,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 270314,270315 } 
    },
    {
        ["offsetX"]=348,
        ["textureHeight"] = 240,
        ["textureWidth"] = 270,
        ["offsetY"] = 13,
        ["fileDataIDs"] = { 270331,270325 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 300,
        ["textureWidth"] = 300,
        ["offsetY"] = 172,
        ["fileDataIDs"] = { 270320,270321,270322,270323 } 
    }
}
				
			}

		}
	}


    local function ShouldShowOriginalTexture(mapId)
        if (mapId == 81 or mapId == 18 or mapId == 14)
		and UnitLevel("player") >= 110 then
            return true
        end
    end
    
	local function FindTilesFrame()
		local allMapFrames = {WorldMapFrame.ScrollContainer.Child:GetChildren()}
		for i = 1, #allMapFrames do
			local frame = allMapFrames[i]
			if frame.detailTilePool then
				return frame 
			end
		end
	end
	local db
	
    C_MapExplorationInfo.GetExploredMapTextures_org = C_MapExplorationInfo.GetExploredMapTextures
	
	C_MapExplorationInfo.GetExploredMapTextures = function(mapId)
        if not mapId then
            return {}
        end

        if not MOD:UserSetting(DGV_REMOVEMAPFOG) then 
            return C_MapExplorationInfo.GetExploredMapTextures_org(mapId)
        end
		
		local artID = C_Map.GetMapArtID(mapId)

		local result = {}
		
		if db and db.global.overlayData then
			if db.global.overlayData[artID] then
				local internalOverlayData = db.global.overlayData[artID]
				for i=1, #internalOverlayData do
					if not result[i] then
						result[i] = internalOverlayData[i]
									
						result[i]["hitRect"] = {
							["top"] = 0,
							["right"] = 0,
							["left"] = 0,
							["bottom"] = 0,
						}
						result[i]["isShownByMouseOver"] = false
					end
				end
			end
		end
		
		return result
	end
	
	--[[Returns:
		{
			mapDirectory = "",
			texData = {
				[mapName1] = 09812341,
				[mapName2] = 98745632
			}
		}
	]]
	
	function MapOverlays.HarvestCurrentMapOverlayInfo()
		if not harvestingDataMode then return end

		local exploredMaps = C_MapExplorationInfo.GetExploredMapTextures_org(WorldMapFrame:GetMapID())
		
		if exploredMaps then
			if not DataExport then
				DataExport = {}
			end
			
			--Currently displayed map
			local currentMapId = WorldMapFrame:GetMapID()
			
			if not DataExport[currentMapId] then
				DataExport[currentMapId] = {}
			end
		
			if exploredMaps then
				for i=1, #exploredMaps do
					local exploredMap = LuaUtils:clone(exploredMaps[i])
					exploredMap.hitRect = nil
					exploredMap.isShownByMouseOver = nil
					DataExport[currentMapId][i] = exploredMap
				end
			end
		end
	end
	
    local function IsExploredId(mapID_, textureId)
        local exploredMapTextures_org = C_MapExplorationInfo.GetExploredMapTextures_org(mapID_);

        for i, info in pairs(exploredMapTextures_org or {}) do
            for j, val in pairs(info.fileDataIDs or {}) do 
                if val == textureId then
                    return true
                end
            end
        end
    end

    MOD.IsExploredId = IsExploredId

    local function FindFogPool()
        for pin in WorldMapFrame:EnumeratePinsByTemplate("MapExplorationPinTemplate") do
            return pin.overlayTexturePool
        end
    end

    MOD.UpdateOverlaysColors = function()
        local overlayTexturePool = FindFogPool()
       
        for textureK, textureV in overlayTexturePool:EnumerateActive() do
            local textId = textureK:GetTexture()

            if  IsExploredId(WorldMapFrame:GetMapID(), textId) then
                textureK:SetVertexColor(.8, .8, .8)
            else
                textureK:SetVertexColor(0.5, 0.5, 0.5)
            end
        end
    end

	local overlayTextures  = {}
	overlayTexturesGPS  = {}    
    local bigOverlays = {}


	-- Code courtesy ckknight
	function MOD:GetCurrentCursorPosition(frame)
	local x, y = GetCursorPosition()
	local left, top = frame:GetLeft(), frame:GetTop()
	local width = frame:GetWidth()
	local height = frame:GetHeight()
	local scale = frame:GetEffectiveScale()
	local cx = (x/scale - left) / width
	local cy = (top - y/scale) / height

		if cx < 0 or cx > 1 or cy < 0 or cy > 1 then
			return nil, nil
	end
	return cx, cy
	end

	local formatCoords = "%.2f, %.2f"


	local UpdateWorldMapFrame = MOD.NoOp
	function MOD:InitializeMapOverlays()
		db = LibStub("AceDB-3.0"):New("MapOverlaysDugis", defaults)
		
		-- todo: find replacement
		--hooksecurefunc("WorldMapFrame_Update", UpdateWorldMapFrame);
		hooksecurefunc(WorldMapFrame, "OnMapChanged", UpdateWorldMapFrame);
		
	end

	function MOD:MapHasOverlays()
		local overlayMap = db.global.overlayData[WorldMapFrame:GetMapID()]
		return overlayMap and next(overlayMap)
	end

	function MapOverlays:Load()
		UpdateWorldMapFrame = function()
			if not MOD.CoordsFrame then
				MOD.CoordsFrame = CreateFrame("Frame", nil, WorldMapFrame)
				MOD.CoordsFrame.Player = MOD.CoordsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
				MOD.CoordsFrame.Cursor = MOD.CoordsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
				MOD.CoordsFrame:SetScript("OnUpdate", function()
					if MOD:UserSetting(DGV_DISPLAYMAPCOORDINATES)
						and not DugisGuideViewer.mapsterloaded
						and not DugisGuideViewer.tomtomloaded
					then
						local _, _, x, y  = DugisGuideViewer:GetUnitPosition("player", true, nil, true)
						if not x or not y then
							MOD.CoordsFrame.Player:SetText("|cffffd200Player:|r ---")
						else
							MOD.CoordsFrame.Player:SetFormattedText("|cffffd200Player:|r %s", formatCoords:format(x*100, y*100))
						end

						if WorldMapFrame.ScrollContainer.Child:GetLeft() then --prevents error on early load
							local cX, cY = MOD:GetCurrentCursorPosition(WorldMapFrame.ScrollContainer.Child)
							if not cX or not cY then
								MOD.CoordsFrame.Cursor:SetText("|cffffd200Cursor:|r ---")
							else
								MOD.CoordsFrame.Cursor:SetFormattedText("|cffffd200Cursor:|r %s", formatCoords:format(cX*100, cY*100))
							end
						end
                        MOD.CoordsFrame:Show()
					else
						MOD.CoordsFrame:Hide()
					end

					if DugisGuideViewer.tomtomloaded
						or MOD:UserSetting(DGV_DISPLAYMAPCOORDINATES)
					then
					
					end
				end)
				MOD.CoordsFrame:Show()
			end

			MOD.CoordsFrame.Player:ClearAllPoints()
			MOD.CoordsFrame.Cursor:ClearAllPoints()
			
			MOD.CoordsFrame.Player:SetPoint("TOPLEFT", WorldMapFrame, "BOTTOM", -120, 20)
			MOD.CoordsFrame.Cursor:SetPoint("TOPLEFT", WorldMapFrame, "BOTTOM", 20, 20)
		
		end
		MOD:InitializeMapOverlays()
        
        UpdateWorldMapFrame()
	end

	function MapOverlays:Unload()
		UpdateWorldMapFrame = MOD.NoOp
		if MOD.CoordsFrame then MOD.CoordsFrame:Hide() end
	end
end
