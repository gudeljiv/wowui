local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("GoldFarmA") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Silverleaf",{
author="support@zygorguides.com",
},[[
step
map Elwynn Forest/0
path follow smart; loop on; ants curved; dist 20
path	35.16,58.15	35.80,61.90	34.96,66.91	35.08,70.72	34.97,74.55
path	31.26,76.29	29.39,72.28	26.34,77.16	26.78,84.53	26.01,88.87
path	28.95,85.90	31.32,84.53	34.00,86.31	35.63,87.61	40.33,90.30
path	42.44,85.05	42.33,79.53	44.78,75.63	57.19,75.30	61.71,78.02
path	64.64,80.21	66.96,82.28	71.53,82.34	74.86,79.96	85.15,82.86
path	88.50,76.38	87.13,70.90	86.64,64.81	83.70,60.88	78.23,58.27
path	74.68,59.68	70.59,61.28	67.25,64.47	63.72,65.35	60.60,62.03
path	56.21,61.31	51.67,60.44	49.08,59.49	44.65,55.81	42.02,54.40
path	39.16,55.56
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
collect Silverleaf##765 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Peacebloom",{
author="support@zygorguides.com",
},[[
step
map Elwynn Forest/0
path follow smart; loop on; ants curved; dist 20
path	35.16,58.15	35.80,61.90	34.96,66.91	35.08,70.72	34.97,74.55
path	31.26,76.29	29.39,72.28	26.34,77.16	26.78,84.53	26.01,88.87
path	28.95,85.90	31.32,84.53	34.00,86.31	35.63,87.61	40.33,90.30
path	42.44,85.05	42.33,79.53	44.78,75.63	57.19,75.30	61.71,78.02
path	64.64,80.21	66.96,82.28	71.53,82.34	74.86,79.96	85.15,82.86
path	88.50,76.38	87.13,70.90	86.64,64.81	83.70,60.88	78.23,58.27
path	74.68,59.68	70.59,61.28	67.25,64.47	63.72,65.35	60.60,62.03
path	56.21,61.31	51.67,60.44	49.08,59.49	44.65,55.81	42.02,54.40
path	39.16,55.56
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
collect Peacebloom##2447 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Earthroot",{
author="support@zygorguides.com",
},[[
step
map Elwynn Forest/0
path follow smart; loop on; ants curved; dist 20
path	37.69,50.56	37.74,52.72	40.46,52.58	44.68,49.88	47.75,50.98
path	50.11,53.78	51.22,59.12	53.58,60.05	55.86,57.19	58.11,58.67
path	61.20,55.26	63.90,54.16	65.95,58.60	68.39,54.25	67.30,49.51
path	66.94,46.11	64.93,39.76	68.35,38.37	73.03,36.59	78.22,39.11
path	80.09,41.77	81.52,47.88	81.14,54.53	84.76,60.10	88.26,63.13
path	89.58,67.45	86.13,79.13	83.85,81.99	79.68,75.80	74.93,72.40
path	71.73,71.92	66.40,71.08	64.94,72.55	60.59,74.44	58.98,78.43
path	55.19,81.63	51.23,81.44	50.22,73.66	44.38,68.40	42.59,67.01
path	39.55,56.74
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 15 Herbalism to collect these.
collect Earthroot##2449 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Mageroyal",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	40.87,42.34	40.99,35.44	40.38,29.51	40.17,23.46	41.23,14.88
path	41.13,12.44	42.83,10.59	46.36,14.30	49.72,14.09	53.28,10.94
path	55.46,15.29	59.73,16.49	61.91,22.17	63.02,31.38	66.61,41.14
path	67.83,45.31	67.40,49.93	64.11,54.95	62.24,59.85	59.35,63.18
path	54.73,67.89	51.47,69.31	48.03,68.82
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 50 Herbalism to collect these.
collect Mageroyal##785 |n
'|goto 48.03,68.82 < 20 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	48.03,68.82	51.47,69.31	54.73,67.89	59.35,63.18	62.24,59.85
path	64.11,54.95	67.40,49.93	67.83,45.31	66.61,41.14	63.02,31.38
path	61.91,22.17	59.73,16.49	55.46,15.29	53.28,10.94	49.72,14.09
path	46.36,14.30	42.83,10.59	41.13,12.44	41.23,14.88	40.17,23.46
path	40.38,29.51	40.99,35.44	40.87,42.34
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 50 Herbalism to collect these.
collect Mageroyal##785 |n
'|goto 40.87,42.34 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Stranglekelp",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	27.56,22.38	28.55,26.38	30.37,30.98	33.88,33.36	30.36,35.99
path	27.70,38.32	26.24,42.31	26.20,47.90	22.96,47.20	21.86,51.72
path	22.04,55.91	25.74,57.13	23.90,60.72	23.70,64.65	26.18,68.29
path	23.58,75.22	24.21,79.36	25.98,84.41	31.39,83.70	33.23,80.90
path	34.46,76.56	37.38,68.78	38.81,62.94
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip They are underwater along the path.
|tip Bring Water Walking Potions.
|tip You will need level 85 Herbalism to collect these.
collect Stranglekelp##3820 |n
'|goto 38.81,62.94 < 20 |noway |c
step
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	38.81,62.94	37.38,68.78	34.46,76.56	33.23,80.90	31.39,83.70
path	25.98,84.41	24.21,79.36	23.58,75.22	26.18,68.29	23.70,64.65
path	23.90,60.72	25.74,57.13	22.04,55.91	21.86,51.72	22.96,47.20
path	26.20,47.90	26.24,42.31	27.70,38.32	30.36,35.99	33.88,33.36
path	30.37,30.98	28.55,26.38	27.56,22.38
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip They are underwater along the path.
|tip Bring Water Walking Potions.
|tip You will need level 85 Herbalism to collect these.
collect Stranglekelp##3820 |n
'|goto 27.56,22.38 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Briarthorn",{
author="support@zygorguides.com",
},[[
step
map Loch Modan
path follow smart; loop on; ants curved; dist 20
path	50.11,70.98	56.14,64.90	60.73,61.95	63.09,57.29	64.59,43.34
path	58.98,33.49	55.48,28.48	53.87,22.04	57.70,16.70	61.33,17.00
path	63.45,23.61	63.96,28.94	67.27,33.55	71.77,36.88	74.64,31.08
path	76.86,42.55	75.17,53.91	77.54,57.68	77.01,64.32	78.39,70.75
path	76.62,73.82	73.00,71.84	67.09,75.89	58.35,76.95	55.16,77.71
path	51.86,73.52
Click herbs as you follow the path around this area
|tip Briarthorn can share a spawn with other herbs in the area, so pick them all.
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 70 Herbalism to collect these.
collect Briarthorn##2450 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Swiftthistle",{
author="support@zygorguides.com",
},[[
step
map Loch Modan
path follow smart; loop on; ants curved; dist 20
path	50.11,70.98	56.14,64.90	60.73,61.95	63.09,57.29	64.59,43.34
path	58.98,33.49	55.48,28.48	53.87,22.04	57.70,16.70	61.33,17.00
path	63.45,23.61	63.96,28.94	67.27,33.55	71.77,36.88	74.64,31.08
path	76.86,42.55	75.17,53.91	77.54,57.68	77.01,64.32	78.39,70.75
path	76.62,73.82	73.00,71.84	67.09,75.89	58.35,76.95	55.16,77.71
path	51.86,73.52
Click herbs as you follow the path around this area
|tip Briarthorn can share a spawn with other herbs in the area, so pick them all.
|tip Swiftthistle has a chance to be gathered from Briarthorn and Mageroyal.
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 70 Herbalism to collect these.
collect Swiftthistle##2452 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Bruiseweed",{
author="support@zygorguides.com",
},[[
step
label "Bruiseweed_1"
map Ashenvale
path follow smart; loop off; dist 20
path	30.47,44.71	27.77,48.81	25.72,50.64	28.38,54.47	34.66,54.20
path	35.41,56.86	34.85,58.62	32.71,59.66	34.71,59.96	38.06,62.62
path	40.48,61.75	39.97,65.16	41.82,64.95	43.85,63.15	47.09,61.20
path	48.42,60.26	49.98,59.22	54.29,60.93	56.36,63.51	57.82,64.38
path	59.14,70.90	60.56,73.42	69.78,74.49	71.98,73.86	74.94,73.92
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 100 Herbalism to collect these.
collect Bruiseweed##2453 |n
'|goto 74.94,73.92 < 20 |noway |c
step
map Ashenvale
path follow smart; loop off; dist 20
path	74.94,73.92	71.98,73.86	69.78,74.49	60.56,73.42	59.14,70.90
path	57.82,64.38	56.36,63.51	54.29,60.93	49.98,59.22	48.42,60.26
path	47.09,61.20	43.85,63.15	41.82,64.95	39.97,65.16	40.48,61.75
path	38.06,62.62	34.71,59.96	32.71,59.66	34.85,58.62	35.41,56.86
path	34.66,54.20	28.38,54.47	25.72,50.64	27.77,48.81	30.47,44.71
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 100 Herbalism to collect these.
collect Bruiseweed##2453 |n
'|goto 30.47,44.71 < 20 |noway |c |next "Bruiseweed_1"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Wild Steelbloom",{
author="support@zygorguides.com",
},[[
step
map Stranglethorn Vale
path follow smart; loop on; ants curved; dist 20
path	35.19,24.89	34.15,16.96	32.35,17.29	29.81,16.22	28.04,17.47
path	25.80,17.04	23.47,14.43	23.84,13.79	26.85,13.53	26.47,10.74
path	26.96,10.08	26.83,8.41	28.93,7.53	31.07,9.11	33.66,7.50
path	35.36,6.91	37.47,8.17	40.26,7.17	42.31,8.80	43.43,9.07
path	44.02,6.96	46.87,7.20	49.23,10.26	46.15,12.93	46.18,15.78
path	48.55,20.93	49.87,26.32	48.46,42.77	46.45,44.95	42.29,44.37
path	39.61,44.79	38.13,35.79
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 115 Herbalism to collect these.
collect Wild Steelbloom##3355 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Grave Moss",{
author="support@zygorguides.com",
},[[
step
Click herbs around this area
|tip Track them on your minimap with "Find Herbs".
|tip They spawn in this small area.
|tip You will need level 120 Herbalism to collect these.
collect Grave Moss##3369 |n |goto Wetlands 44.07,26.40
You can find more inside the crypt at [44.27,25.39]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Kingsblood",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	46.75,25.55	51.58,29.02	56.21,30.36	59.67,33.23	62.46,34.02
path	61.92,38.94	58.55,43.68	56.51,48.27	44.88,34.82	41.25,33.98
path	35.44,31.57	31.52,36.24	26.99,34.94	18.37,36.35	13.78,37.41
path	14.84,33.80	18.22,32.79	19.10,26.35	21.55,27.19	24.28,28.73
path	27.93,30.36	32.61,27.99	35.45,24.60	38.43,23.41	40.84,24.23
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 125 Herbalism to collect these.
collect Kingsblood##3356 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Liferoot",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Wetlands
path follow smart; loop off; dist 20
path	39.88,29.56	42.39,32.16	44.42,36.02	50.85,37.60	53.92,41.52
path	55.96,45.32	59.97,50.83	61.97,56.83	64.42,68.06	63.29,74.88
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 150 Herbalism to collect these.
collect Liferoot##3357 |n
'|goto 63.29,74.88 < 20 |noway |c
step
map Wetlands
path follow smart; loop off; dist 20
path	63.29,74.88	64.42,68.06	61.97,56.83	59.97,50.83	55.96,45.32
path	53.92,41.52	50.85,37.60	44.42,36.02	42.39,32.16	39.88,29.56
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 150 Herbalism to collect these.
collect Liferoot##3357 |n
'|goto 39.88,29.56 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Fadeleaf",{
author="support@zygorguides.com",
},[[
step
map Swamp of Sorrows
path follow smart; loop on; ants curved; dist 20
path	20.50,54.53	16.62,58.22	15.71,65.71	12.68,68.05	10.73,63.62
path	12.41,55.83	15.50,47.83	18.39,45.92	22.07,39.95	28.92,38.70
path	33.28,38.90	38.62,34.97	47.12,33.93	51.82,34.91	51.62,41.06
path	44.78,45.30	37.49,50.34	33.07,52.19	27.05,54.68	22.47,57.13
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip Watch out for horde guards along the main road.
|tip You will need level 160 Herbalism to collect these.
collect Fadeleaf##3818 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Goldthorn",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	30.73,67.93	31.34,65.94	31.29,63.30	33.47,59.16	34.72,58.50
path	35.99,56.40	34.16,54.11	33.67,52.84	34.22,50.55	35.98,48.96
path	36.98,48.70	39.98,44.91	40.43,43.96	40.36,42.07	41.34,40.39
path	43.07,37.30	43.31,39.18	43.52,40.25	44.37,39.85	44.49,41.37
path	44.53,43.67	45.58,43.90	46.54,43.36	47.13,43.87	47.84,42.42
path	47.79,40.43	49.03,37.60	48.82,36.22	49.70,31.42	49.45,29.64
path	50.03,27.63	50.56,26.44	49.98,23.97	47.47,22.67	46.33,24.57
path	44.74,25.50	43.42,26.50	40.87,28.82	40.14,32.21	38.73,33.10
path	36.97,34.22	36.66,38.10	36.42,41.03	34.95,40.76	33.81,39.53
path	31.73,42.03	30.29,43.54	28.79,44.84	28.04,47.89	27.69,50.35
path	29.34,52.92	29.92,54.14	31.79,52.55
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 170 Herbalism to collect these.
collect Goldthorn##3821 |n
'|goto 31.79,52.55 < 20 |noway |c
step
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	33.43,55.29	33.15,56.95	31.66,58.87	31.13,61.25	30.56,63.99
path	30.40,67.21
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 170 Herbalism to collect these.
collect Goldthorn##3821 |n
'|goto 30.40,67.21 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Khadgar's Whisker",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	30.73,67.93	31.34,65.94	31.29,63.30	33.47,59.16	34.72,58.50
path	35.99,56.40	34.16,54.11	33.67,52.84	34.22,50.55	35.98,48.96
path	36.98,48.70	39.98,44.91	40.43,43.96	40.36,42.07	41.34,40.39
path	43.07,37.30	43.31,39.18	43.52,40.25	44.37,39.85	44.49,41.37
path	44.53,43.67	45.58,43.90	46.54,43.36	47.13,43.87	47.84,42.42
path	47.79,40.43	49.03,37.60	48.82,36.22	49.70,31.42	49.45,29.64
path	50.03,27.63	50.56,26.44	49.98,23.97	47.47,22.67	46.33,24.57
path	44.74,25.50	43.42,26.50	40.87,28.82	40.14,32.21	38.73,33.10
path	36.97,34.22	36.66,38.10	36.42,41.03	34.95,40.76	33.81,39.53
path	31.73,42.03	30.29,43.54	28.79,44.84	28.04,47.89	27.69,50.35
path	29.34,52.92	29.92,54.14	31.79,52.55
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 185 Herbalism to collect these.
collect Khadgar's Whisker##3358 |n
'|goto 31.79,52.55 < 20 |noway |c
step
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	33.43,55.29	33.15,56.95	31.66,58.87	31.13,61.25	30.56,63.99
path	30.40,67.21
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 185 Herbalism to collect these.
collect Khadgar's Whisker##3358 |n
'|goto 30.40,67.21 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Wintersbite",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Alterac Mountains
path follow smart; loop off; dist 20
path	36.21,70.12	38.50,71.59	42.34,67.24	40.46,63.73	45.07,62.49
path	49.57,60.07	50.10,56.20	49.14,51.29	45.91,45.67	47.02,42.14
path	46.73,38.06	44.90,32.01
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 195 Herbalism to collect these.
collect Wintersbite##3819 |n
'|goto 44.90,32.01 < 20 |noway |c
step
map Alterac Mountains
path follow smart; loop off; dist 20
path	44.90,32.01	46.73,38.06	47.02,42.14	45.91,45.67	49.14,51.29
path	50.10,56.20	49.57,60.07	45.07,62.49	40.46,63.73	42.34,67.24
path	38.50,71.59	36.21,70.12
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 195 Herbalism to collect these.
collect Wintersbite##3819 |n
'|goto 36.21,70.12 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Wildvine",{
author="support@zygorguides.com",
},[[
step
Kill Vilebranch Enemies around this area
collect Wildvine##8153 |n |goto The Hinterlands 47.57,66.46
|tip They have a 10% chance to be gathered from Purple Lotus around the Altar.
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 210 Herbalism to collect these.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Firebloom",{
author="support@zygorguides.com",
},[[
step
map Blasted Lands
path follow smart; loop on; ants curved; dist 20
path	59.95,26.91	63.87,32.24	62.52,37.16	61.93,40.77	63.59,47.87
path	60.16,47.06	56.61,47.07	52.58,50.11	48.61,51.34	45.83,49.50
path	46.56,43.37	45.38,37.03	44.55,26.43	45.95,23.01	49.76,23.71
path	51.28,26.22	52.49,31.62	51.40,36.19	53.41,38.07	55.97,36.24
path	57.46,32.43	58.67,28.99
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 205 Herbalism to collect these.
collect Firebloom##4625 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Purple Lotus",{
author="support@zygorguides.com",
},[[
step
map Azshara
path follow smart; loop on; ants curved; dist 20
path	13.44,76.03	13.49,73.41	13.96,72.13	15.04,72.61	16.67,72.10
path	18.11,69.50	19.30,63.70	19.72,61.12	21.39,60.74	24.79,58.76
path	25.63,56.77	25.97,53.77	24.66,50.64	25.95,49.40	27.49,50.93
path	29.47,52.59	30.30,54.30	32.31,55.35	32.55,57.96	31.89,60.78
path	34.71,61.62	35.79,60.81	36.20,59.43	36.50,57.60	38.27,56.97
path	38.93,60.17	38.62,62.10	37.62,63.76	37.16,67.40	36.65,71.52
path	36.55,73.48	35.12,76.04	32.98,79.88	31.50,80.61	28.68,80.41
path	25.35,79.42	24.06,79.46	19.93,77.32	18.50,79.02	16.39,79.69
path	14.67,79.40
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 210 Herbalism to collect these.
collect Purple Lotus##8831 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Arthas' Tears",{
author="support@zygorguides.com",
},[[
step
map Western Plaguelands
path follow smart; loop on; ants curved; dist 20
path	38.46,71.59	40.21,70.25	41.92,68.36	43.65,67.66	43.55,64.99
path	42.58,61.73	44.99,61.15	45.83,59.71	47.54,60.16	48.88,62.22
path	50.20,63.25	51.12,65.36	51.20,68.70	52.77,69.69	54.81,66.60
path	55.29,62.85	56.78,59.81	58.67,58.12	58.67,58.12	61.36,51.95
path	59.63,51.59	56.24,51.02	55.02,49.73	53.44,46.46	51.12,44.12
path	49.07,42.44	46.93,39.92	46.45,37.04	47.66,35.14	49.62,33.23
path	48.75,31.25	48.00,31.04	46.53,31.70	44.60,32.62	43.64,35.30
path	44.60,37.79	45.12,41.59	45.73,46.00	45.79,47.79	43.94,50.26
path	40.48,52.81	39.18,52.53	38.68,53.52	35.80,54.28	34.28,55.75
path	33.16,57.76	33.14,59.71	32.83,61.21	33.06,63.79	34.28,66.60
path	36.12,68.62	37.31,71.53
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 220 Herbalism to collect these.
collect Arthas' Tears##8836 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Sungrass",{
author="support@zygorguides.com",
},[[
step
map Blasted Lands
path follow smart; loop on; ants curved; dist 20
path	59.95,26.91	63.87,32.24	62.52,37.16	61.93,40.77	63.59,47.87
path	60.16,47.06	56.61,47.07	52.58,50.11	48.61,51.34	45.83,49.50
path	46.56,43.37	45.38,37.03	44.55,26.43	45.95,23.01	49.76,23.71
path	51.28,26.22	52.49,31.62	51.40,36.19	53.41,38.07	55.97,36.24
path	57.46,32.43	58.67,28.99
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 230 Herbalism to collect these.
collect Sungrass##8838 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Blindweed",{
author="support@zygorguides.com",
},[[
step
map Swamp of Sorrows
path follow smart; loop on; ants curved; dist 20
path	23.34,47.48	26.00,39.24	28.21,37.10	31.38,35.00	36.11,36.48
path	38.30,35.54	40.98,35.26	42.49,39.06	44.13,40.53	46.07,41.10
path	46.56,38.70	49.85,36.00	52.70,36.48	54.71,36.25	57.38,33.20
path	58.78,30.30	62.57,29.33	66.36,28.36	68.29,25.21	69.20,20.52
path	69.38,15.92	72.73,13.20	76.51,14.32	78.04,18.24	81.03,21.94
path	82.49,25.63	82.43,31.77	82.80,37.29	86.93,38.06	88.09,44.02
path	88.14,49.77	85.09,53.96	86.43,57.71	84.56,62.68	84.28,67.90
path	81.40,71.41	78.10,69.78	76.69,64.12	78.72,58.47	80.88,55.22
path	81.42,48.27	81.70,43.61	79.06,40.69	77.48,38.74	76.64,34.28
path	73.75,33.11	70.93,33.86	68.69,31.71	65.67,35.50	61.30,37.56
path	58.02,38.46	54.71,41.87	53.10,42.33	49.93,42.29	47.27,43.26
path	44.52,45.19	42.66,47.65	39.83,49.22	36.79,51.04	33.83,51.96
path	29.04,54.25
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 235 Herbalism to collect these.
collect Blindweed##8839 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Ghost Mushroom",{
author="support@zygorguides.com",
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	57.75,46.26	59.21,44.51	59.83,40.90	57.54,38.67	55.82,38.52
path	54.48,40.89	54.34,43.82	55.65,46.02
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 245 Herbalism to collect these.
|tip They spawn inside of the cave along this path as well as outside of it.
collect Ghost Mushroom##8845 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Gromsblood",{
author="support@zygorguides.com",
},[[
step
map Blasted Lands
path follow smart; loop on; ants curved; dist 20
path	59.95,26.91	63.87,32.24	62.52,37.16	61.93,40.77	63.59,47.87
path	60.16,47.06	56.61,47.07	52.58,50.11	48.61,51.34	45.83,49.50
path	46.56,43.37	45.38,37.03	44.55,26.43	45.95,23.01	49.76,23.71
path	51.28,26.22	52.49,31.62	51.40,36.19	53.41,38.07	55.97,36.24
path	57.46,32.43	58.67,28.99
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 250 Herbalism to collect these.
collect Gromsblood##8846 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Golden Sansam",{
author="support@zygorguides.com",
},[[
step
map Azshara
path follow smart; loop on; ants curved; dist 20
path	44.97,34.08	45.34,30.56	45.01,27.72	44.00,22.97	44.61,20.55
path	45.91,19.60	48.17,18.74	50.79,18.10	52.77,19.45	53.43,20.10
path	54.10,20.23	56.85,20.66	59.23,18.80	61.89,16.89	64.79,17.01
path	66.41,15.27	69.57,16.37	71.70,16.63	73.96,18.69	75.86,21.19
path	76.87,24.70	79.46,24.05	79.40,26.62	77.14,28.54	74.71,29.28
path	71.72,29.19	69.51,28.09	67.74,26.09	64.29,23.93	61.47,23.67
path	59.32,24.37	56.53,25.81	54.31,28.58	52.61,32.17	49.37,31.47
path	46.94,31.71
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 260 Herbalism to collect these.
collect Golden Sansam##13464 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Dreamfoil",{
author="support@zygorguides.com",
},[[
step
map Azshara
path follow smart; loop on; ants curved; dist 20
path	44.97,34.08	45.34,30.56	45.01,27.72	44.00,22.97	44.61,20.55
path	45.91,19.60	48.17,18.74	50.79,18.10	52.77,19.45	53.43,20.10
path	54.10,20.23	56.85,20.66	59.23,18.80	61.89,16.89	64.79,17.01
path	66.41,15.27	69.57,16.37	71.70,16.63	73.96,18.69	75.86,21.19
path	76.87,24.70	79.46,24.05	79.40,26.62	77.14,28.54	74.71,29.28
path	71.72,29.19	69.51,28.09	67.74,26.09	64.29,23.93	61.47,23.67
path	59.32,24.37	56.53,25.81	54.31,28.58	52.61,32.17	49.37,31.47
path	46.94,31.71
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 270 Herbalism to collect these.
collect Dreamfoil##13463 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Mountain Silversage",{
author="support@zygorguides.com",
},[[
step
map Un'Goro Crater
path follow smart; loop on; ants curved; dist 20
path	69.50,80.51	66.73,78.96	62.06,80.45	60.17,83.38	57.90,84.92
path	56.43,85.63	52.59,86.79	50.45,85.64	47.59,86.84	44.06,85.48
path	40.43,83.69	37.58,82.20	36.74,80.02	34.35,78.80	30.60,79.47
path	29.81,78.29	29.45,73.80	29.51,71.95	30.47,70.66	30.12,68.78
path	26.87,68.47	26.22,63.87	24.35,55.86	24.60,51.19	24.66,49.08
path	24.29,47.04	24.87,40.95	26.12,37.25	26.47,32.27	28.16,29.95
path	29.28,30.78	30.53,29.41	29.59,24.96	30.56,20.83	33.11,20.72
path	34.48,21.20	36.41,20.34	38.57,16.60	42.23,16.10	44.74,14.15
path	48.26,13.20	49.78,17.80	51.76,16.54	52.14,13.12	54.40,13.42
path	56.79,14.48	59.79,16.53	62.08,16.53	63.95,19.36	65.85,21.43
path	66.83,23.10	67.79,22.98	68.24,20.16	70.91,20.97	71.45,25.67
path	71.86,28.59	74.60,32.13	74.81,36.14	76.10,40.85	76.77,46.27
path	76.23,50.57	76.85,54.91	75.63,60.70	74.66,64.47	74.30,69.24
path	71.82,70.72	70.92,71.71	71.15,74.12	70.59,75.37	70.92,79.06
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 280 Herbalism to collect these.
collect Mountain Silversage##13465 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Plaguebloom",{
author="support@zygorguides.com",
},[[
step
map Eastern Plaguelands
path follow smart; loop on; ants curved; dist 20
path	63.32,54.67	67.59,55.28	72.06,54.50	75.06,53.69	77.43,53.29
path	78.36,55.80	79.17,59.16	80.07,63.69	80.31,67.80	78.88,71.68
path	76.88,73.45	75.52,74.46	74.76,76.67	72.94,78.41	68.81,75.52
path	66.81,76.30	65.03,73.91	64.71,69.43	63.81,66.25	63.25,64.01
path	63.98,59.07
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 285 Herbalism to collect these.
collect Plaguebloom##13466 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Icecap",{
author="support@zygorguides.com",
},[[
step
map Winterspring
path follow smart; loop on; ants curved; dist 20
path	51.15,36.38	49.02,37.97	47.29,38.82	46.26,37.85	44.98,36.98
path	43.34,37.35	42.00,36.66	40.04,36.95	37.55,36.29	37.03,38.50
path	37.04,40.67	36.22,41.42	34.89,40.49	32.81,37.93	31.53,36.07
path	29.97,36.02	29.97,39.23	29.90,42.23	30.63,44.36	31.61,44.78
path	32.31,44.29	34.16,43.86	34.79,42.97	35.73,43.41	36.55,44.20
path	37.95,44.18	40.05,43.83	41.97,43.60	43.29,44.09	44.44,42.87
path	45.25,41.37	45.82,40.53	46.38,39.95	47.29,40.48	48.43,42.60
path	49.89,44.73	50.67,45.63	52.44,46.41	53.08,44.56	53.42,43.72
path	55.09,43.38	56.62,42.13	57.86,40.63	58.81,39.07	58.04,36.73
path	56.38,36.22	54.08,33.77
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 290 Herbalism to collect these.
collect Icecap##13467 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Herbalism\\Farming Guides\\Black Lotus",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Burning Steppes
path follow smart; loop off; dist 20
path	75.56,48.10	67.51,44.35	65.55,42.14	64.07,37.82	63.48,37.82
path	60.30,40.06	49.65,36.46	46.29,34.47	43.06,33.76	41.88,37.36
path	41.46,40.03	42.68,42.14	42.11,43.86	39.76,44.39	35.84,48.89
path	33.34,55.11	31.73,57.80	27.13,61.16	25.14,54.29	22.87,50.09
path	18.10,44.02	15.47,40.51	15.42,34.23	15.35,30.51
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 300 Herbalism to collect these.
collect Black Lotus##13468 |n
|tip These are extremely rare.
|tip Pick other herbs on the path to have a chance to spawn them.
'|goto 15.35,30.51 < 20 |noway |c
step
map Burning Steppes
path follow smart; loop off; dist 20
path	15.35,30.51	15.42,34.23	15.47,40.51	18.10,44.02	22.87,50.09
path	25.14,54.29	27.13,61.16	31.73,57.80	33.34,55.11	35.84,48.89
path	39.76,44.39	42.11,43.86	42.68,42.14	41.46,40.03	41.88,37.36
path	43.06,33.76	46.29,34.47	49.65,36.46	60.30,40.06	63.48,37.82
path	64.07,37.82	65.55,42.14	67.51,44.35	75.56,48.10
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 300 Herbalism to collect these.
collect Black Lotus##13468 |n
|tip These are extremely rare.
|tip Pick other herbs on the path to have a chance to spawn them.
'|goto 75.56,48.10 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Copper Ore",{
author="support@zygorguides.com",
},[[
step
map Elwynn Forest
path follow smart; loop on; ants curved; dist 20
path	30.84,52.85	31.66,56.55	30.70,59.27	33.97,61.71	32.67,69.74
path	34.82,71.77	38.65,70.47	41.90,72.73	38.79,78.16	36.73,83.14
path	38.86,85.10	40.47,81.19	42.54,75.73	43.46,72.43	45.88,71.66
path	48.66,72.57	50.67,73.61	52.16,76.22	51.59,81.68	50.51,84.27
path	52.44,85.57	54.07,81.63	55.50,80.65	57.18,77.77	59.76,76.99
path	64.90,71.42	66.82,69.10	70.81,68.32	75.97,68.43	74.95,64.93
path	73.11,60.29	76.43,54.83	77.84,50.88	75.35,46.25	73.10,46.01
path	71.20,49.01	71.93,55.39	68.33,54.29	67.11,57.66	65.88,58.62
path	65.45,55.47	63.86,53.92	61.15,54.32	59.49,56.50	57.71,57.94
path	55.65,58.04	53.51,57.94	52.34,58.34	51.04,58.74	49.28,57.01
path	50.05,53.17	48.15,51.19	47.15,49.29	43.66,49.22	41.39,51.02
path	39.84,53.01	36.99,52.64	34.92,51.69	35.76,48.57	34.85,46.74
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
collect Copper Ore##2770 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Rough Stone",{
author="support@zygorguides.com",
},[[
step
map Elwynn Forest
path follow smart; loop on; ants curved; dist 20
path	30.84,52.85	31.66,56.55	30.70,59.27	33.97,61.71	32.67,69.74
path	34.82,71.77	38.65,70.47	41.90,72.73	38.79,78.16	36.73,83.14
path	38.86,85.10	40.47,81.19	42.54,75.73	43.46,72.43	45.88,71.66
path	48.66,72.57	50.67,73.61	52.16,76.22	51.59,81.68	50.51,84.27
path	52.44,85.57	54.07,81.63	55.50,80.65	57.18,77.77	59.76,76.99
path	64.90,71.42	66.82,69.10	70.81,68.32	75.97,68.43	74.95,64.93
path	73.11,60.29	76.43,54.83	77.84,50.88	75.35,46.25	73.10,46.01
path	71.20,49.01	71.93,55.39	68.33,54.29	67.11,57.66	65.88,58.62
path	65.45,55.47	63.86,53.92	61.15,54.32	59.49,56.50	57.71,57.94
path	55.65,58.04	53.51,57.94	52.34,58.34	51.04,58.74	49.28,57.01
path	50.05,53.17	48.15,51.19	47.15,49.29	43.66,49.22	41.39,51.02
path	39.84,53.01	36.99,52.64	34.92,51.69	35.76,48.57	34.85,46.74
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
collect Rough Stone##2835 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Tin Ore",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	34.74,16.82	36.33,18.75	39.75,20.23	43.44,23.27	46.05,22.77
path	48.20,23.86	49.91,23.03	53.21,23.66	55.80,22.78	57.30,23.64
path	58.74,23.33	60.36,21.58	61.25,24.78	63.07,26.13	64.55,28.11
path	63.58,30.34	64.11,33.78	65.20,39.01	67.23,42.83	71.03,45.91
path	70.92,50.14	67.86,53.66	67.02,56.69	66.31,60.65	66.18,65.59
path	67.37,73.31	59.48,72.47	57.49,74.14	56.16,78.29	54.13,78.16
path	54.29,74.22	54.19,68.98	56.08,60.41	56.30,58.46	55.28,53.86
path	53.93,48.40	52.05,43.80	48.11,40.65	44.62,39.47	42.08,40.16
path	38.66,37.95	34.42,38.78
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 65 Mining to collect these.
collect Tin Ore##2771 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Coarse Stone",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	34.74,16.82	36.33,18.75	39.75,20.23	43.44,23.27	46.05,22.77
path	48.20,23.86	49.91,23.03	53.21,23.66	55.80,22.78	57.30,23.64
path	58.74,23.33	60.36,21.58	61.25,24.78	63.07,26.13	64.55,28.11
path	63.58,30.34	64.11,33.78	65.20,39.01	67.23,42.83	71.03,45.91
path	70.92,50.14	67.86,53.66	67.02,56.69	66.31,60.65	66.18,65.59
path	67.37,73.31	59.48,72.47	57.49,74.14	56.16,78.29	54.13,78.16
path	54.29,74.22	54.19,68.98	56.08,60.41	56.30,58.46	55.28,53.86
path	53.93,48.40	52.05,43.80	48.11,40.65	44.62,39.47	42.08,40.16
path	38.66,37.95	34.42,38.78
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 65 Mining to collect these.
collect Coarse Stone##2836 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Silver Ore",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	34.74,16.82	36.33,18.75	39.75,20.23	43.44,23.27	46.05,22.77
path	48.20,23.86	49.91,23.03	53.21,23.66	55.80,22.78	57.30,23.64
path	58.74,23.33	60.36,21.58	61.25,24.78	63.07,26.13	64.55,28.11
path	63.58,30.34	64.11,33.78	65.20,39.01	67.23,42.83	71.03,45.91
path	70.92,50.14	67.86,53.66	67.02,56.69	66.31,60.65	66.18,65.59
path	67.37,73.31	59.48,72.47	57.49,74.14	56.16,78.29	54.13,78.16
path	54.29,74.22	54.19,68.98	56.08,60.41	56.30,58.46	55.28,53.86
path	53.93,48.40	52.05,43.80	48.11,40.65	44.62,39.47	42.08,40.16
path	38.66,37.95	34.42,38.78
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 75 Mining to collect these.
collect Silver Ore##2775 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Moss Agate",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	34.74,16.82	36.33,18.75	39.75,20.23	43.44,23.27	46.05,22.77
path	48.20,23.86	49.91,23.03	53.21,23.66	55.80,22.78	57.30,23.64
path	58.74,23.33	60.36,21.58	61.25,24.78	63.07,26.13	64.55,28.11
path	63.58,30.34	64.11,33.78	65.20,39.01	67.23,42.83	71.03,45.91
path	70.92,50.14	67.86,53.66	67.02,56.69	66.31,60.65	66.18,65.59
path	67.37,73.31	59.48,72.47	57.49,74.14	56.16,78.29	54.13,78.16
path	54.29,74.22	54.19,68.98	56.08,60.41	56.30,58.46	55.28,53.86
path	53.93,48.40	52.05,43.80	48.11,40.65	44.62,39.47	42.08,40.16
path	38.66,37.95	34.42,38.78
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 65 Mining to collect Tin Ore nodes and 75 to collect Silver Ore nodes.
collect Moss Agate##1206 |n
|tip These are a rare drop from Tin and Silver Ore nodes.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Iron Ore",{
author="support@zygorguides.com",
},[[
step
map Arathi Highlands
path follow smart; loop on; ants curved; dist 20
path	76.64,42.59	75.00,44.93	72.65,48.07	70.58,55.05	69.99,58.40
path	72.92,59.03	72.28,63.63	72.78,66.86	71.75,66.15	69.15,72.54
path	67.17,70.90	63.52,73.55	59.48,74.71	59.32,70.74	56.16,71.89
path	50.82,78.41	47.96,82.44	42.53,80.75	43.02,77.16	40.39,71.86
path	37.95,67.63	38.52,68.50	33.94,66.02	34.59,61.64	33.70,56.77
path	33.45,53.94	33.65,50.19	35.00,47.28	32.96,46.68	31.68,45.41
path	32.34,42.64	31.42,41.24	25.23,43.10	20.94,39.12	20.02,35.80
path	19.12,33.36	22.43,31.28	23.48,24.90	26.93,20.65	28.65,14.18
path	28.96,16.96	31.62,18.63	30.96,20.36	33.19,21.23	36.35,24.61
path	39.97,25.62	40.21,28.79	43.97,30.51	45.70,33.02	48.08,33.60
path	49.78,36.76	52.14,36.11	52.75,31.99	54.80,33.13	58.19,32.50
path	58.02,34.22	59.94,35.97	62.25,32.06	64.69,35.58	64.49,26.56
path	66.77,27.64	70.39,27.07	70.47,30.74	71.07,38.63
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 125 Mining to collect these.
collect Iron Ore##2772 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Heavy Stone",{
author="support@zygorguides.com",
},[[
step
map Arathi Highlands
path follow smart; loop on; ants curved; dist 20
path	76.64,42.59	75.00,44.93	72.65,48.07	70.58,55.05	69.99,58.40
path	72.92,59.03	72.28,63.63	72.78,66.86	71.75,66.15	69.15,72.54
path	67.17,70.90	63.52,73.55	59.48,74.71	59.32,70.74	56.16,71.89
path	50.82,78.41	47.96,82.44	42.53,80.75	43.02,77.16	40.39,71.86
path	37.95,67.63	38.52,68.50	33.94,66.02	34.59,61.64	33.70,56.77
path	33.45,53.94	33.65,50.19	35.00,47.28	32.96,46.68	31.68,45.41
path	32.34,42.64	31.42,41.24	25.23,43.10	20.94,39.12	20.02,35.80
path	19.12,33.36	22.43,31.28	23.48,24.90	26.93,20.65	28.65,14.18
path	28.96,16.96	31.62,18.63	30.96,20.36	33.19,21.23	36.35,24.61
path	39.97,25.62	40.21,28.79	43.97,30.51	45.70,33.02	48.08,33.60
path	49.78,36.76	52.14,36.11	52.75,31.99	54.80,33.13	58.19,32.50
path	58.02,34.22	59.94,35.97	62.25,32.06	64.69,35.58	64.49,26.56
path	66.77,27.64	70.39,27.07	70.47,30.74	71.07,38.63
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 125 Mining to collect these.
collect Heavy Stone##2838 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Gold Ore",{
author="support@zygorguides.com",
},[[
step
map Arathi Highlands
path follow smart; loop on; ants curved; dist 20
path	76.64,42.59	75.00,44.93	72.65,48.07	70.58,55.05	69.99,58.40
path	72.92,59.03	72.28,63.63	72.78,66.86	71.75,66.15	69.15,72.54
path	67.17,70.90	63.52,73.55	59.48,74.71	59.32,70.74	56.16,71.89
path	50.82,78.41	47.96,82.44	42.53,80.75	43.02,77.16	40.39,71.86
path	37.95,67.63	38.52,68.50	33.94,66.02	34.59,61.64	33.70,56.77
path	33.45,53.94	33.65,50.19	35.00,47.28	32.96,46.68	31.68,45.41
path	32.34,42.64	31.42,41.24	25.23,43.10	20.94,39.12	20.02,35.80
path	19.12,33.36	22.43,31.28	23.48,24.90	26.93,20.65	28.65,14.18
path	28.96,16.96	31.62,18.63	30.96,20.36	33.19,21.23	36.35,24.61
path	39.97,25.62	40.21,28.79	43.97,30.51	45.70,33.02	48.08,33.60
path	49.78,36.76	52.14,36.11	52.75,31.99	54.80,33.13	58.19,32.50
path	58.02,34.22	59.94,35.97	62.25,32.06	64.69,35.58	64.49,26.56
path	66.77,27.64	70.39,27.07	70.47,30.74	71.07,38.63
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 155 Mining to collect these.
collect Gold Ore##2776 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Mithril Ore",{
author="support@zygorguides.com",
},[[
step
map Badlands
path follow smart; loop on; ants curved; dist 20
path	26.84,74.76	25.28,78.53	19.71,81.32	14.75,83.82	12.50,85.54
path	7.98,80.56	6.30,74.40	8.68,67.97	17.19,68.54	15.13,72.43
path	17.19,77.39	21.25,75.06	25.11,72.08
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 175 Mining to collect these.
collect Mithril Ore##3858 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Solid Stone",{
author="support@zygorguides.com",
},[[
step
map Badlands
path follow smart; loop on; ants curved; dist 20
path	26.84,74.76	25.28,78.53	19.71,81.32	14.75,83.82	12.50,85.54
path	7.98,80.56	6.30,74.40	8.68,67.97	17.19,68.54	15.13,72.43
path	17.19,77.39	21.25,75.06	25.11,72.08
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 175 Mining to collect these.
collect Solid Stone##7912 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Truesilver Ore",{
author="support@zygorguides.com",
},[[
step
map Badlands
path follow smart; loop on; ants curved; dist 20
path	26.84,74.76	25.28,78.53	19.71,81.32	14.75,83.82	12.50,85.54
path	7.98,80.56	6.30,74.40	8.68,67.97	17.19,68.54	15.13,72.43
path	17.19,77.39	21.25,75.06	25.11,72.08
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 230 Mining to collect these.
collect Truesilver Ore##7911 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Dark Iron Ore",{
author="support@zygorguides.com",
},[[
step
map Burning Steppes
path follow smart; loop on; ants curved; dist 20
path	47.24,33.58	57.79,36.68	60.09,40.49	60.24,30.28	62.87,24.54
path	64.47,23.32	65.45,24.20	64.95,33.28	71.55,39.13	79.50,25.16
path	93.16,52.72	85.24,62.18	74.63,61.27	74.12,55.90	68.15,59.00
path	64.92,57.85	62.02,54.94	47.51,59.50	43.25,60.21
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 230 Mining to collect these.
|tip These are a rare spawn.
|tip However, they can be found more consistently inside the Blackrock Depths dungeon and Molten Core raid.
collect Dark Iron Ore##11370 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Thorium Ore",{
author="support@zygorguides.com",
},[[
step
map Un'Goro Crater
path follow smart; loop on; ants curved; dist 20
path	66.46,78.95	64.56,79.71	61.79,84.21	59.34,84.18	57.63,86.04
path	54.50,86.69	51.13,86.82	48.27,87.30	45.98,86.58	42.89,85.00
path	40.79,83.52	37.91,83.14	36.77,80.17	33.58,79.05	30.40,79.61
path	28.89,76.98	28.97,71.52	26.00,67.67	25.93,63.53	24.59,58.51
path	23.95,53.04	24.40,48.21	23.89,44.76	24.71,41.12	26.26,36.59
path	26.62,31.21	28.29,29.47	29.59,25.66	29.89,20.92	33.32,20.67
path	36.29,20.47	38.67,16.00	41.73,15.77	43.32,14.12	46.94,13.03
path	49.79,13.83	52.84,12.88	56.31,14.04	59.61,16.58	62.25,16.02
path	64.19,19.90	65.99,21.01	68.51,20.26	71.19,20.89	71.21,23.75
path	71.75,28.19	74.76,32.46	75.06,37.15	76.32,43.15	76.67,48.32
path	77.05,53.09	76.56,57.02	75.35,61.97	74.66,68.05	72.92,70.46
path	71.39,73.80	71.00,79.21	68.32,79.90
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 245 Mining to collect these.
collect Thorium Ore##10620 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Dense Stone",{
author="support@zygorguides.com",
},[[
step
map Un'Goro Crater
path follow smart; loop on; ants curved; dist 20
path	66.46,78.95	64.56,79.71	61.79,84.21	59.34,84.18	57.63,86.04
path	54.50,86.69	51.13,86.82	48.27,87.30	45.98,86.58	42.89,85.00
path	40.79,83.52	37.91,83.14	36.77,80.17	33.58,79.05	30.40,79.61
path	28.89,76.98	28.97,71.52	26.00,67.67	25.93,63.53	24.59,58.51
path	23.95,53.04	24.40,48.21	23.89,44.76	24.71,41.12	26.26,36.59
path	26.62,31.21	28.29,29.47	29.59,25.66	29.89,20.92	33.32,20.67
path	36.29,20.47	38.67,16.00	41.73,15.77	43.32,14.12	46.94,13.03
path	49.79,13.83	52.84,12.88	56.31,14.04	59.61,16.58	62.25,16.02
path	64.19,19.90	65.99,21.01	68.51,20.26	71.19,20.89	71.21,23.75
path	71.75,28.19	74.76,32.46	75.06,37.15	76.32,43.15	76.67,48.32
path	77.05,53.09	76.56,57.02	75.35,61.97	74.66,68.05	72.92,70.46
path	71.39,73.80	71.00,79.21	68.32,79.90
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 245 Mining to collect these.
collect Dense Stone##12365 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Guardian Stone",{
author="support@zygorguides.com",
},[[
step
map Un'Goro Crater
path follow smart; loop on; ants curved; dist 20
path	40.24,18.78	37.48,20.20	33.48,23.57	40.40,25.92	43.96,29.92
path	44.56,36.72	43.43,40.74	44.16,43.79	48.24,41.64	51.27,39.78
path	56.65,39.87	54.16,36.20	55.85,31.39	57.79,26.10	56.20,21.10
path	56.97,14.88	53.59,13.78	51.39,17.24	48.13,13.45
Kill Stone Guardians as you follow the path around this area
|tip These are level 60-61 Elite enemies.
collect Guardian Stone##12809 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Mining\\Farming Guides\\Elementium Ore",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
click Orb of Command##179879 |goto 48.92,64.47
Teleport to Blackwing Lair |goto Blackwing Lair 0.00,0.00 < 1000 |noway |c
|tip You must be attuned to enter the raid.
step
Inside the Blackwing Lair Raid:
kill Blackwing Technician##13996+
collect Elementium Ore##18562 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Linen Cloth",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Be sure to enter the mine as well.
collect Linen Cloth##2589 |n |goto Westfall 44.55,25.01
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Wool Cloth",{
author="support@zygorguides.com",
},[[
step
Follow the road up |goto Redridge Mountains 35.71,43.17 < 15 |only if walking
Continue following the road |goto 47.06,30.39 < 15 |only if walking
Follow the path up |goto 40.87,15.00 < 10 |only if walking
Kill Blackrock enemies around this area
collect Wool Cloth##2592 |n |goto 36.22,9.93
You can find more inside the cave at [33.21,6.91]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Silk Cloth",{
author="support@zygorguides.com",
},[[
step
Kill Galak enemies around this area
|tip You can find more inside the cave.
collect Silk Cloth##4306 |n |goto Thousand Needles 44.01,37.41
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Mageweave Cloth",{
author="support@zygorguides.com",
},[[
step
Kill Dunemaul enemies around this area
collect Mageweave Cloth##4338 |n |goto Tanaris 40.50,55.50
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Runecloth",{
author="support@zygorguides.com",
},[[
step
Kill Scarlet enemies around this area
collect Runecloth###14047 |n |goto Western Plaguelands 47.85,33.38
You can find more around [44.35,33.96]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Felcloth",{
author="support@zygorguides.com",
},[[
step
Kill Jadefire enemies around this area
collect Felcloth##14256 |n |goto Felwood 37.17,67.00
You can find more around [32.71,66.66]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Mooncloth",{
author="support@zygorguides.com",
},[[
step
label "Farm_Felcloth"
Kill Jadefire enemies around this area
collect Felcloth##14256 |n |goto Felwood 37.17,67.00
Click here to transmute Felcloth into Mooncloth |confirm
|tip It only takes 2 Felcloth to make a Mooncloth, but it requires a rare Tailoring pattern and has a 4 day cooldown.
step
Open Your Tailoring Crafting Panel:
_<Create Mooncloth>_
|tip This spell has a 4 day cooldown.
collect Mooncloth##14342 |n |goto Ashenvale 60.19,72.90
Click here to farm more Felcloth |confirm |next "Farm_Felcloth"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Spider's Silk",{
author="support@zygorguides.com",
},[[
step
Enter the cave |goto Wetlands 52.79,62.90 < 20 |walk
Kill enemies around this area
|tip Inside the cave.
collect Spider's Silk##3182 |n |goto 48.51,60.67
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Thick Spider's Silk",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Eastern Plaguelands 77.56,47.20 < 10 |only if walking
Kill Crypt enemies around this area
|tip You can find more inside the nearby crypt buildings.
collect Thick Spider's Silk##4337 |n |goto 83.60,42.07
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Shadow Silk",{
author="support@zygorguides.com",
},[[
step
kill Deathstrike Tarantula##769+
collect Shadow Silk##10285 |n |goto Swamp of Sorrows 58.74,62.39
|tip These have a low drop rate.
You can find more around [66.70,68.65]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Tailoring\\Farming Guides\\Ironweb Spider Silk",{
author="support@zygorguides.com",
},[[
step
kill Sand Skitterer##11738+
collect Ironweb Spider Silk##14227 |n |goto Silithus 56.25,26.22
|tip These have a low drop rate.
You can find more around: |notinsticky
[54.15,18.47]
[63.01,18.18]
[64.31,29.61]
[38.69,34.85]
[35.71,30.35]
[35.29,20.57]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Brilliant Smallfish",{
author="support@zygorguides.com",
},[[
step
Fish in the open water
collect Raw Brilliant Smallfish##6291 |n |goto Elwynn Forest 33.59,63.52
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Chunk of Boar Meat",{
author="support@zygorguides.com",
},[[
step
kill Stonetusk Boar##113
collect Chunk of Boar Meat##769 |n |goto Elwynn Forest 41.81,87.22
You can find more around this area [32.96,84.95]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Small Egg",{
author="support@zygorguides.com",
},[[
step
map Darkshore
path follow smart; loop on; dist 20
path	42.54,49.69	42.84,48.54	43.76,47.68	44.83,47.93	46.07,49.39
path	46.23,50.98	45.59,52.40	44.96,53.22	44.69,54.49	43.84,53.83
path	43.01,53.12	42.10,54.15	41.70,53.04	41.80,50.80	41.19,48.45
Kill Moonkin enemies along this path
collect Small Egg##6889 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Small Spider Leg",{
author="support@zygorguides.com",
},[[
step
map Teldrassil
path follow smart; loop on; dist 20
path	61.26,54.48	59.86,54.83	58.84,56.13	57.82,55.52	56.99,57.22
path	55.71,58.31	54.17,58.29	51.90,56.43	51.01,57.05	51.06,58.72
path	51.50,61.70	51.21,65.25	51.97,66.36	53.49,68.85	53.68,66.50
path	54.51,65.63	55.15,63.62	56.43,62.23	57.59,61.30	58.39,61.25
path	59.64,62.24	61.03,61.51	62.34,60.71	62.85,58.55	62.70,56.22
path	62.20,55.24
kill Webwood Lurker##1998+
collect Small Spider Leg##5465 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Stringy Wolf Meat",{
author="support@zygorguides.com",
},[[
step
map Dun Morogh
path follow smart; loop on; dist 20
path	48.83,44.33	49.91,45.80	51.35,45.50	52.65,45.75	54.52,46.88
path	53.16,48.13	52.07,50.43	50.38,52.50	49.29,54.64	48.27,55.36
path	47.24,53.86	46.41,52.12	46.05,49.96	44.75,48.06	42.48,47.21
path	40.23,47.20	38.74,46.65	36.95,45.83	35.43,45.11	34.49,44.49
path	32.83,46.26	31.94,47.31	30.21,46.67	30.51,44.36	31.98,42.52
path	33.05,39.49	36.17,37.53	37.64,35.53	38.86,32.48	41.00,31.62
path	43.08,31.61	44.32,33.52	44.37,37.07	45.30,40.37
Kill Wolf enemies along this path
collect Stringy Wolf Meat##2672 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Slitherskin Mackerel",{
author="support@zygorguides.com",
},[[
step
Fish in the open water
collect Raw Slitherskin Mackerel##6303 |n |goto Teldrassil 56.25,93.72
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Crag Boar Rib",{
author="support@zygorguides.com",
},[[
step
map Dun Morogh
path follow smart; loop on; dist 20
path	48.31,47.26	50.56,47.82	52.50,48.96	51.18,50.98	50.25,52.44
path	49.29,54.42	48.28,56.64	48.54,58.79	48.34,61.32	47.52,63.19
path	45.85,63.76	45.37,63.31	46.29,61.25	46.73,58.19	46.92,56.16
path	46.51,54.00	46.40,50.75	47.10,49.38	47.15,47.78
Kill Boar enemies along this path
collect Crag Boar Rib##2886 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Spider Ichor",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	27.50,18.10	30.27,19.59	29.15,24.55	29.84,29.06	32.14,30.71
path	35.13,29.65	37.20,31.58	36.37,35.45	35.03,38.40	33.26,40.88
path	32.40,45.35	33.05,47.42	34.34,51.88	36.47,52.74	39.14,50.95
path	39.83,54.29	42.01,58.27	44.93,63.94	49.35,69.89	52.66,69.99
path	55.03,68.30	57.07,65.55	60.01,64.00	63.50,65.52	64.87,60.86
path	65.69,52.00	68.27,52.19	71.58,51.39	74.71,49.53	75.51,45.81
path	76.80,40.70	76.45,36.95	76.44,33.17	72.32,36.15	69.02,35.67
path	64.80,30.93	62.26,24.80	60.72,21.63	60.32,16.09	57.40,15.76
path	56.11,17.39
Kill Lurker enemies along this path
collect Spider Ichor##3174 |n
'|goto 56.11,17.39 < 20 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	56.11,17.39	57.40,15.76	60.32,16.09	60.72,21.63	62.26,24.80
path	64.80,30.93	69.02,35.67	72.32,36.15	76.44,33.17	76.45,36.95
path	76.80,40.70	75.51,45.81	74.71,49.53	71.58,51.39	68.27,52.19
path	65.69,52.00	64.87,60.86	63.50,65.52	60.01,64.00	57.07,65.55
path	55.03,68.30	52.66,69.99	49.35,69.89	44.93,63.94	42.01,58.27
path	39.83,54.29	39.14,50.95	36.47,52.74	34.34,51.88	33.05,47.42
path	32.40,45.35	33.26,40.88	35.03,38.40	36.37,35.45	37.20,31.58
path	35.13,29.65	32.14,30.71	29.84,29.06	29.15,24.55	30.27,19.59
path	27.50,18.10
Kill Lurker enemies along this path
collect Spider Ichor##3174 |n
'|goto 27.50,18.10 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Coyote Meat",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Westfall
path follow smart; loop off; dist 20
path	62.45,42.12	61.05,38.49	59.20,30.20	58.69,26.18	58.85,22.18
path	55.99,22.99	53.72,26.55	51.15,26.31	48.14,25.64	47.04,19.68
path	44.81,17.52	42.78,19.23	41.83,24.14	41.27,26.78	42.70,31.93
path	39.81,33.77	36.63,30.63	34.38,34.44	33.43,38.91	35.02,42.09
path	38.49,42.87
Kill Coyote enemies along this path
collect Coyote Meat##2673 |n
'|goto 38.49,42.87 < 20 |noway |c
step
map Westfall
path follow smart; loop off; dist 20
path	38.49,42.87	35.02,42.09	33.43,38.91	34.38,34.44	36.63,30.63
path	39.81,33.77	42.70,31.93	41.27,26.78	41.83,24.14	42.78,19.23
path	44.81,17.52	47.04,19.68	48.14,25.64	51.15,26.31	53.72,26.55
path	55.99,22.99	58.85,22.18	58.69,26.18	59.20,30.20	61.05,38.49
path	62.45,42.12
Kill Coyote enemies along this path
collect Coyote Meat##2673 |n
'|goto 62.45,42.12 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Boar Intestines",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Westfall
path follow smart; loop off; dist 20
path	62.45,42.12	61.05,38.49	59.20,30.20	58.69,26.18	58.85,22.18
path	55.99,22.99	53.72,26.55	51.15,26.31	48.14,25.64	47.04,19.68
path	44.81,17.52	42.78,19.23	41.83,24.14	41.27,26.78	42.70,31.93
path	39.81,33.77	36.63,30.63	34.38,34.44	33.43,38.91	35.02,42.09
path	38.51,42.85
Kill Boar enemies along this path
collect Boar Intestines##3172 |n
'|goto 38.51,42.85 < 20 |noway |c
step
map Westfall
path follow smart; loop off; dist 20
path	38.51,42.85	35.02,42.09	33.43,38.91	34.38,34.44	36.63,30.63
path	39.81,33.77	42.70,31.93	41.27,26.78	41.83,24.14	42.78,19.23
path	44.81,17.52	47.04,19.68	48.14,25.64	51.15,26.31	53.72,26.55
path	55.99,22.99	58.85,22.18	58.69,26.18	59.20,30.20	61.05,38.49
path	62.45,42.12
Kill Boar enemies along this path
collect Boar Intestines##3172 |n
'|goto 62.45,42.12 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Stringy Vulture Meat",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Westfall
path follow smart; loop off; dist 20
path	62.45,42.12	61.05,38.49	59.20,30.20	58.69,26.18	58.85,22.18
path	55.99,22.99	53.72,26.55	51.15,26.31	48.14,25.64	47.04,19.68
path	44.81,17.52	42.78,19.23	41.83,24.14	41.27,26.78	42.70,31.93
path	39.81,33.77	36.63,30.63	34.38,34.44	33.43,38.91	35.02,42.09
path	38.51,42.85
Kill Vulture enemies along this path
collect Stringy Vulture Meat##729 |n
'|goto 38.51,42.85 < 20 |noway |c
step
map Westfall
path follow smart; loop off; dist 20
path	38.51,42.85	35.02,42.09	33.43,38.91	34.38,34.44	36.63,30.63
path	39.81,33.77	42.70,31.93	41.27,26.78	41.83,24.14	42.78,19.23
path	44.81,17.52	47.04,19.68	48.14,25.64	51.15,26.31	53.72,26.55
path	55.99,22.99	58.85,22.18	58.69,26.18	59.20,30.20	61.05,38.49
path	62.45,42.12
Kill Vulture enemies along this path
collect Stringy Vulture Meat##729 |n
'|goto 62.45,42.12 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Strider Meat",{
author="support@zygorguides.com",
},[[
step
map Darkshore
path follow smart; loop on; dist 20
path	41.72,45.81	42.40,44.51	43.58,42.34	44.66,42.12	46.20,41.09
path	47.32,40.10	47.90,39.85	48.42,38.69	48.61,37.31	48.50,35.08
path	48.73,33.75	49.68,32.60	50.53,30.20	50.70,28.40	50.02,26.68
path	49.23,25.39	48.00,23.46	46.94,23.20	45.63,23.60	44.92,25.24
path	44.27,27.17	43.90,29.44	43.88,31.28	43.81,33.32	42.75,34.53
path	41.64,34.45	40.24,33.90	39.53,35.70	39.27,37.38	39.07,39.41
path	39.65,40.83	40.30,42.11	39.99,44.14	38.96,46.50	39.25,47.99
path	40.57,48.26
Kill Strider enemies along this path
collect Strider Meat##5469 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Kodo Meat",{
author="support@zygorguides.com",
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	46.73,67.35	46.61,69.24	46.70,71.56	46.79,75.01	46.84,79.96
path	45.00,78.85	44.87,75.78	45.31,72.93	45.54,70.61	45.76,68.23
path	45.93,66.82
Kill Kodo enemies along this path
collect Kodo Meat##5467 |n
|tip Thunderheads will not drop this item.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Murloc Eye",{
author="support@zygorguides.com",
},[[
step
Kill Murloc enemies around this area
|tip They spawn all along the coast, so you can move down to get more.
collect Murloc Eye##730 |n |goto Westfall 55.73,9.49
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Bear Meat",{
author="support@zygorguides.com",
},[[
step
map Darkshore
path follow smart; loop on; ants curved; dist 20
path	45.52,35.10	46.86,35.15	47.88,33.99	48.82,34.11	49.47,33.15
path	49.81,31.71	49.00,30.97	48.64,29.50	49.29,27.40	48.64,27.07
path	48.40,25.88	48.18,24.49	47.62,23.22	46.59,22.69	45.54,23.42
path	44.37,23.40	44.27,24.98	43.83,26.43	44.32,27.91	43.94,29.27
path	44.78,30.11	45.40,31.46	44.78,32.44	43.97,32.76	42.43,32.68
path	41.39,33.60	41.66,35.17	42.07,37.43	42.42,39.82	43.17,41.92
path	44.41,42.90	45.25,43.21	45.48,41.84
Kill Bear enemies along this path
collect Bear Meat##3173 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Goretusk Snout",{
author="support@zygorguides.com",
},[[
step
map Westfall
path follow smart; loop on; dist 20
path	54.77,43.68	52.06,43.69	49.12,42.27	45.09,41.88	43.96,44.88
path	41.67,44.84	39.02,39.33	39.16,34.42	35.06,35.23	33.65,38.77
path	34.88,42.29	35.10,44.27	37.31,45.80	39.99,48.75	42.97,53.04
path	41.95,57.70	39.61,60.26	40.13,64.84	42.23,64.99	45.21,63.19
path	46.83,61.93	47.60,58.82	49.94,58.52	51.66,61.20	54.37,59.63
path	56.14,55.00	55.49,50.62	55.02,47.55
Kill Goretusk enemies along this path
collect Goretusk Snout##731 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Goretusk Liver",{
author="support@zygorguides.com",
},[[
step
map Westfall
path follow smart; loop on; dist 20
path	54.77,43.68	52.06,43.69	49.12,42.27	45.09,41.88	43.96,44.88
path	41.67,44.84	39.02,39.33	39.16,34.42	35.06,35.23	33.65,38.77
path	34.88,42.29	35.10,44.27	37.31,45.80	39.99,48.75	42.97,53.04
path	41.95,57.70	39.61,60.26	40.13,64.84	42.23,64.99	45.21,63.19
path	46.83,61.93	47.60,58.82	49.94,58.52	51.66,61.20	54.37,59.63
path	56.14,55.00	55.49,50.62	55.02,47.55
Kill Goretusk enemies along this path
collect Goretusk Liver##723 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Crawler Meat",{
author="support@zygorguides.com",
},[[
step
map Westfall
path follow smart; loop off; dist 20
path	51.32,9.67	49.06,10.01	44.72,8.70	41.78,10.34	38.85,13.51
path	36.20,18.29	33.45,22.08	31.88,24.30
Kill Crawler enemies around this area
|tip You can find more further down the coast.
collect Crawler Meat##2674 |n
'|goto 31.88,24.30 < 20 |noway |c
step
map Westfall
path follow smart; loop off; dist 20
path	31.88,24.30	33.45,22.08	36.20,18.29	38.85,13.51	41.78,10.34
path	44.72,8.70	49.06,10.01	51.32,9.67
Kill Crawler enemies around this area
|tip You can find more further down the coast.
collect Crawler Meat##2674 |n
'|goto 51.32,9.67 < 20 |noway |c
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Crawler Claw",{
author="support@zygorguides.com",
},[[
step
map Westfall
path follow smart; loop off; dist 20
path	51.32,9.67	49.06,10.01	44.72,8.70	41.78,10.34	38.85,13.51
path	36.20,18.29	33.45,22.08	31.88,24.30
Kill Crawler enemies around this area
|tip You can find more further down the coast.
collect Crawler Claw##2675 |n
'|goto 31.88,24.30 < 20 |noway |c
step
map Westfall
path follow smart; loop off; dist 20
path	31.88,24.30	33.45,22.08	36.20,18.29	38.85,13.51	41.78,10.34
path	44.72,8.70	49.06,10.01	51.32,9.67
Kill Crawler enemies around this area
|tip You can find more further down the coast.
collect Crawler Claw##2675 |n
'|goto 51.32,9.67 < 20 |noway |c
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Clam Meat",{
author="support@zygorguides.com",
},[[
step
Kill Murloc enemies around this area
|tip They are found all along the coastline.
collect Small Barnacled Clam##5523 |n
use the Small Barnacled Clam##5523
collect Clam Meat##5503 |n |goto Westfall 37.26,15.67
|tip They are inside of the Small Barnacled Clams.
You can find more around here [31.16,26.10]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Boar Ribs",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	27.50,18.10	30.27,19.59	29.15,24.55	29.84,29.06	32.14,30.71
path	35.13,29.65	37.20,31.58	36.37,35.45	35.03,38.40	33.26,40.88
path	32.40,45.35	33.05,47.42	34.34,51.88	36.47,52.74	39.14,50.95
path	39.83,54.29	42.01,58.27	44.93,63.94	49.35,69.89	52.66,69.99
path	55.03,68.30	57.07,65.55	60.01,64.00	63.50,65.52	64.87,60.86
path	65.69,52.00	68.27,52.19	71.58,51.39	74.71,49.53	75.51,45.81
path	76.80,40.70	76.45,36.95	76.44,33.17	72.32,36.15	69.02,35.67
path	64.80,30.93	62.26,24.80	60.72,21.63	60.32,16.09	57.40,15.76
path	56.11,17.39
Kill Boar enemies along this path
collect Boar Ribs##2677 |n
'|goto 56.11,17.39 < 20 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	56.11,17.39	57.40,15.76	60.32,16.09	60.72,21.63	62.26,24.80
path	64.80,30.93	69.02,35.67	72.32,36.15	76.44,33.17	76.45,36.95
path	76.80,40.70	75.51,45.81	74.71,49.53	71.58,51.39	68.27,52.19
path	65.69,52.00	64.87,60.86	63.50,65.52	60.01,64.00	57.07,65.55
path	55.03,68.30	52.66,69.99	49.35,69.89	44.93,63.94	42.01,58.27
path	39.83,54.29	39.14,50.95	36.47,52.74	34.34,51.88	33.05,47.42
path	32.40,45.35	33.26,40.88	35.03,38.40	36.37,35.45	37.20,31.58
path	35.13,29.65	32.14,30.71	29.84,29.06	29.15,24.55	30.27,19.59
path	27.50,18.10
Kill Boar enemies along this path
collect Boar Ribs##2677 |n
'|goto 27.50,18.10 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Crocolisk Meat",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	59.07,58.33	61.96,54.52	62.60,51.20	62.93,48.10	61.85,44.72
path	59.99,41.23	58.93,39.15	56.80,39.21	54.29,41.28	52.90,36.82
path	56.38,35.56	58.29,34.14	57.78,30.70	58.28,23.79	56.87,21.44
Kill Crocolisk enemies along this path
collect Crocolisk Meat##2924 |n
'|goto 56.87,21.44 < 20 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	56.87,21.44	58.28,23.79	57.78,30.70	58.29,34.14	56.38,35.56
path	52.90,36.82	54.29,41.28	56.80,39.21	58.93,39.15	59.99,41.23
path	61.85,44.72	62.93,48.10	62.60,51.20	61.96,54.52	59.07,58.33
Kill Crocolisk enemies along this path
collect Crocolisk Meat##2924 |n
'|goto 59.07,58.33 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Rainbow Fin Albacore",{
author="support@zygorguides.com",
},[[
step
Fish in the Open Water
collect Raw Rainbow Fin Albacore##6361 |n |goto Wetlands 9.32,61.63
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Longjaw Mud Snapper",{
author="support@zygorguides.com",
},[[
step
Fish in the Open Water
collect Raw Longjaw Mud Snapper##6289 |n |goto Stormwind City 45.37,57.54
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Tough Condor Meat",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Redridge Mountains
path follow smart; loop off; dist 20
path	40.90,39.07	42.13,33.74	45.43,30.76	48.37,31.50	49.98,33.27
path	51.31,34.71	54.57,38.75	56.34,40.65	58.08,41.06	61.81,39.87
path	65.27,42.43
Kill Condor enemies along this path
collect Tough Condor Meat##1080 |n
'|goto 65.27,42.43 < 20 |noway |c
step
map Redridge Mountains
path follow smart; loop off; dist 20
path	62.49,39.72	59.22,40.52	56.35,41.43	57.19,45.31	55.36,45.91
path	52.71,42.81	50.52,41.90	49.25,41.66	46.85,37.78	44.32,37.81
path	42.56,37.84	39.61,39.63
Kill Condor enemies along this path
collect Tough Condor Meat##1080 |n
'|goto 39.61,39.63 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Soft Frenzy Flesh",{
author="support@zygorguides.com",
},[[
step
map Darkshore
path follow smart; loop on; dist 20
path	34.24,60.68	31.91,61.15	33.77,66.17	33.07,67.99	32.05,71.24
path	31.26,73.36	32.40,75.21	32.04,77.87	34.60,77.45	34.68,74.58
path	34.79,72.62	35.34,70.00	35.82,66.96	35.50,65.25	35.59,62.93
path	35.54,60.26
kill Coastal Frenzy##2174+
|tip They are underwater along this path.
collect Soft Frenzy Flesh##5468 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Loch Frenzy",{
author="support@zygorguides.com",
},[[
step
map Loch Modan
path follow smart; loop on; dist 20
path	44.56,30.72	44.43,24.86	44.40,19.25	47.08,17.29	50.60,16.64
path	52.93,18.26	55.24,22.03	56.79,25.41	56.33,29.61	52.70,31.04
path	49.85,32.36	46.69,32.19
kill Loch Frenzy##1193+
|tip They are underwater along this path.
collect Raw Loch Frenzy##6317 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Murloc Fin",{
author="support@zygorguides.com",
},[[
step
map Ashenvale
path follow smart; loop on; ants curved; dist 20
path	20.90,40.21	21.33,41.92	21.06,43.30	20.66,44.48	19.75,43.65
path	19.08,42.84	18.81,41.34	18.96,40.20	19.58,41.07
Kill Saltspittle enemies around this area
collect Murloc Fin##1468 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Lean Wolf Flank",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Duskwood
path follow smart; loop off; dist 20
path	63.16,28.80	64.53,25.32	66.25,22.72	68.11,20.39	65.79,19.10
path	63.93,18.00	61.85,17.35	61.24,19.93	59.17,22.31	57.44,22.15
path	55.99,19.56	54.52,17.35	52.93,14.73	51.60,17.10	50.35,19.66
path	49.58,17.59	48.56,16.46	46.52,16.89	44.73,18.76	43.31,20.29
path	41.58,18.79	39.78,19.76	37.72,19.38	36.39,21.44	37.40,24.54
path	35.14,24.60	32.82,24.47	31.96,27.24	29.31,27.36	27.36,26.54
path	25.34,27.61	22.46,25.92	20.45,25.75	18.66,23.98	16.18,27.47
path	14.08,27.45	12.25,30.98	10.25,32.63
Kill Wolf enemies around this area
collect Lean Wolf Flank##1015 |n
'|goto 10.25,32.63 < 20 |noway |c
step
map Duskwood
path follow smart; loop off; dist 20
path	10.25,32.63	12.25,30.98	14.08,27.45	16.18,27.47	18.66,23.98
path	20.45,25.75	22.46,25.92	25.34,27.61	27.36,26.54	29.31,27.36
path	31.96,27.24	32.82,24.47	35.14,24.60	37.40,24.54	36.39,21.44
path	37.72,19.38	39.78,19.76	41.58,18.79	43.31,20.29	44.73,18.76
path	46.52,16.89	48.56,16.46	49.58,17.59	50.35,19.66	51.60,17.10
path	52.93,14.73	54.52,17.35	55.99,19.56	59.17,22.31	61.24,19.93
path	61.85,17.35	63.93,18.00	65.79,19.10	68.11,20.39	66.25,22.72
path	64.53,25.32	63.16,28.80
Kill Wolf enemies around this area
collect Lean Wolf Flank##1015 |n
'|goto 63.16,28.80 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Sagefish",{
author="support@zygorguides.com",
},[[
step
Fish from Sagefish Schools in the water around this area
collect Raw Sagefish##21071 |n |goto Hillsbrad Foothills 62.51,43.06
|tip Follow the river north for more schools.
|tip You will need level 100 Fishing to catch these.
You can find more around [69.87,13.66]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Big Bear Meat",{
author="support@zygorguides.com",
},[[
step
map Hillsbrad Foothills
path follow smart; loop on; dist 20
path	38.33,38.22	38.83,41.84	40.63,44.03	42.02,47.77	43.74,49.21
path	44.53,52.30	48.19,47.24	53.47,48.86	54.78,44.77	56.02,39.61
path	53.80,34.79	52.80,31.91	50.32,32.11	48.17,34.26	45.68,36.53
path	43.61,37.51	41.05,36.09	37.81,33.55
Kill Bear enemies around this area
collect Big Bear Meat##3730 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raptor Egg",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; dist 20
path	20.63,48.84	21.22,52.36	22.52,55.60	23.52,53.14	24.47,52.25
path	24.33,49.93	26.28,48.80	26.45,47.06	27.37,45.66	23.64,46.15
path	22.34,50.55
Kill Raptor enemies around this area
collect Raptor Egg##3685 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Thunder Lizard Tail",{
author="support@zygorguides.com",
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	46.58,56.30	48.58,57.05	48.69,58.20	48.80,59.11	48.24,60.56
path	48.43,62.12	48.27,63.65	47.64,65.24	46.80,67.81	46.67,68.85
path	46.58,71.45	47.01,73.09	46.67,74.29	47.26,75.11	47.86,75.81
path	48.51,76.74	49.30,77.70	48.91,78.77	47.66,80.13	46.53,79.48
path	44.91,79.17	44.65,78.42	44.58,76.68	44.47,75.54	44.75,74.17
path	45.56,72.50	45.56,70.73	45.79,69.01	46.03,66.53	45.23,64.79
path	45.30,63.46	46.25,61.69	46.94,60.01	47.00,58.41
Kill Thunderhead enemies around this area
collect Thunder Lizard Tail##5470 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Tangy Clam Meat",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; dist 20
path	15.21,40.13	17.36,39.06	19.36,38.16	22.88,37.14	24.91,36.76
path	24.41,33.77	23.10,33.59	21.34,34.34	19.64,31.98	18.24,31.36
path	16.84,29.42	15.14,30.74	14.96,33.33	14.32,35.71	13.91,38.13
path	14.03,40.90
Kill Bluegill enemies around this area
collect Thick-shelled Clam##5524 |n
use the Thick-shelled Clam##5524
collect Tangy Clam Meat##5504 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Tender Crocolisk Meat",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Dustwallow Marsh
path follow smart; loop off; dist 20
path	42.01,28.23	41.27,30.48	40.81,32.17	39.51,33.86	38.27,35.06
path	39.30,36.33	40.52,36.90	41.08,38.12	42.23,39.13	42.29,41.27
path	40.44,41.83	39.76,43.93	39.29,45.36	38.51,45.82	37.54,46.50
path	36.53,47.94	35.50,49.39	36.60,52.40	38.28,53.98	40.81,54.72
path	41.62,55.99	40.68,58.48	40.53,61.02
Kill Drywallow enemies along this path
collect Tender Crocolisk Meat##3667 |n
'|goto 40.53,61.02 < 20 |noway |c
step
map Dustwallow Marsh
path follow smart; loop off; dist 20
path	40.53,61.02	40.68,58.48	41.62,55.99	40.81,54.72	38.28,53.98
path	36.60,52.40	35.50,49.39	36.53,47.94	37.54,46.50	38.51,45.82
path	39.29,45.36	39.76,43.93	40.44,41.83	42.29,41.27	42.23,39.13
path	41.08,38.12	40.52,36.90	39.30,36.33	38.27,35.06	39.51,33.86
path	40.81,32.17	41.27,30.48	42.01,28.23
Kill Drywallow enemies along this path
collect Tender Crocolisk Meat##3667 |n
'|goto 42.01,28.23 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Lion Meat",{
author="support@zygorguides.com",
},[[
step
map Hillsbrad Foothills
path follow smart; loop on; ants curved; dist 20
path	53.45,35.50	54.82,31.40	50.85,30.94	48.73,31.20	47.14,34.19
path	44.82,36.37	42.94,35.61	40.84,34.75	37.39,30.82	38.60,37.24
path	39.02,42.97	41.37,42.61	42.89,40.98	44.43,45.21	47.44,44.25
path	50.74,47.10	53.15,47.46	55.37,44.48	54.69,42.88	56.10,41.00
path	56.82,37.61
kill Starving Mountain Lion##2384+
collect Lion Meat##3731 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Stag Meat",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Stonetalon Mountains
path follow smart; loop off; dist 20
path	50.21,36.84	49.75,34.63	48.15,33.61	46.91,32.12	46.84,28.49
path	46.38,25.94	45.77,24.36	44.95,22.28	44.66,19.95	44.13,17.21
path	43.26,16.08	41.50,15.94	40.17,15.24	39.42,12.31	39.94,10.54
path	40.29,8.62	40.73,6.34	39.49,6.04
Kill Courser enemies along this path
collect Stag Meat##5471 |n
'|goto 39.49,6.04 < 20 |noway |c
step
map Stonetalon Mountains
path follow smart; loop off; dist 20
path	39.49,6.04	40.73,6.34	40.29,8.62	39.94,10.54	39.42,12.31
path	40.17,15.24	41.50,15.94	43.26,16.08	44.13,17.21	44.66,19.95
path	44.95,22.28	45.77,24.36	46.38,25.94	46.84,28.49	46.91,32.12
path	48.15,33.61	49.75,34.63	50.21,36.84
Kill Courser enemies along this path
collect Stag Meat##5471 |n
'|goto 50.21,36.84 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Bristle Whisker Catfish",{
author="support@zygorguides.com",
},[[
step
Fish in the Open Water
collect Raw Bristle Whisker Catfish##6308 |n |goto Stormwind City 45.37,57.54
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Gooey Spider Leg",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Duskwood
path follow smart; loop off; dist 20
path	75.39,23.25	75.70,20.27	72.81,20.02	68.45,21.26	66.04,20.18
path	64.38,23.56	62.25,25.40	58.25,19.25	55.59,20.51	53.13,20.33
path	50.65,16.19	48.36,17.34	46.63,16.65
Kill Spider enemies along this path
collect Gooey Spider Leg##2251 |n
'|goto 46.63,16.65 < 20 |noway |c
step
map Duskwood
path follow smart; loop off; dist 20
path	46.63,16.65	48.36,17.34	50.65,16.19	53.13,20.33	55.59,20.51
path	58.25,19.25	62.25,25.40	64.38,23.56	66.04,20.18	68.45,21.26
path	72.81,20.02	75.70,20.27	75.39,23.25
Kill Spider enemies along this path
collect Gooey Spider Leg##2251 |n
'|goto 75.39,23.25 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Mystery Meat",{
author="support@zygorguides.com",
},[[
step
map Desolace
path follow smart; loop on; ants curved; dist 20
path	51.29,44.72	53.48,47.10	55.33,46.17	57.48,48.07	58.96,47.63
path	60.75,46.43	62.24,44.62	63.57,45.94	63.27,49.13	61.69,55.00
path	61.88,58.44	62.94,65.32	61.88,68.70	62.74,70.12	63.61,72.54
path	61.39,75.80	59.53,76.20	60.04,79.61	59.47,82.26	56.81,86.32
path	54.85,86.07	52.40,86.59	50.42,87.94	48.11,87.57	44.00,86.02
path	41.14,82.82	42.54,77.20	43.81,73.09	42.57,70.49	41.77,66.08
path	42.23,61.68	42.51,57.62	43.63,55.03	43.45,50.95	41.83,49.60
path	41.89,45.46	45.18,40.98	45.64,38.42	48.07,39.13	50.82,41.52
Kill enemies around this area
collect Mystery Meat##12037 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Red Wolf Meat",{
author="support@zygorguides.com",
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	16.99,49.54	14.76,51.94	16.34,54.97	19.20,54.81	21.00,55.69
path	22.67,53.75	24.13,52.68	22.29,51.46	20.61,50.68	19.10,49.49
kill Mangy Silvermane##2923+
collect Red Wolf Meat##12203 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Turtle Meat",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Hillsbrad Foothills
path follow smart; loop off; dist 20
path	55.45,57.43	56.82,50.74	58.10,47.76	59.58,47.03	61.27,45.60
path	61.69,42.44	63.66,39.71	66.35,38.58	67.91,34.65	68.11,31.05
path	68.53,27.79	68.76,23.80	68.71,17.57	69.11,12.97	71.53,8.15
map Alterac Mountains
path	73.57,66.04	77.21,62.35	79.49,58.40	81.26,54.60	84.17,52.70
path	87.28,49.70	90.76,47.21
Kill Snapjaw enemies along this path
collect Turtle Meat##3712 |n
'|goto 90.76,47.21 < 20 |noway |c
step
map Alterac Mountains
path follow smart; loop off; dist 20
path	90.76,47.21	87.28,49.70	84.17,52.70	81.26,54.60	79.49,58.40
path	77.21,62.35	73.57,66.04
map Hillsbrad Foothills
path	71.53,8.15	69.11,12.97	68.71,17.57	68.76,23.80	68.53,27.79
path	68.11,31.05	67.91,34.65	66.35,38.58	63.66,39.71	61.69,42.44
path	61.27,45.60	59.58,47.03	58.10,47.76	56.82,50.74	55.45,57.43
Kill Snapjaw enemies along this path
collect Turtle Meat##3712 |n
'|goto 55.45,57.43 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Tiger Meat",{
author="support@zygorguides.com",
},[[
step
map Stranglethorn Vale
path follow smart; loop on; ants curved; dist 20
path	37.17,11.59	36.03,11.59	35.04,11.61	33.93,9.90	32.59,9.49
path	31.34,8.40	31.71,9.95	32.62,10.51	33.06,11.72	33.88,12.60
path	34.58,13.61	35.43,12.75	36.60,13.36	37.41,14.77	38.14,14.47
path	38.22,13.67	38.39,12.20	39.14,10.33	39.08,9.00	37.71,9.37
Kill Tiger enemies around this area
collect Tiger Meat##12202 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raptor Flesh",{
author="support@zygorguides.com",
},[[
step
label "Path_One"
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	30.64,25.20	30.40,23.48	31.45,23.06	31.36,21.37	30.71,18.47
path	29.83,16.33	28.80,16.28	27.47,16.45	26.82,17.50	26.75,15.82
path	25.58,15.93	23.70,15.50
Kill Raptor enemies around this area
collect Raptor Flesh##12184 |n
'|goto 23.70,15.50 < 20 |noway |c
step
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	23.70,15.50	25.58,15.93	26.75,15.82	26.82,17.50	27.47,16.45
path	28.80,16.28	29.83,16.33	30.71,18.47	31.36,21.37	31.45,23.06
path	30.40,23.48	30.64,25.20
Kill Raptor enemies around this area
collect Raptor Flesh##12184 |n
'|goto 30.64,25.20 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Mithril Head Trout",{
author="support@zygorguides.com",
},[[
step
Fish in the Open Water
collect Raw Mithril Head Trout##8365 |n |goto Dustwallow Marsh 59.95,34.54
|tip You will need level 130 Fishing to catch these.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Buzzard Wing",{
author="support@zygorguides.com",
},[[
step
map Desolace
path follow smart; loop on; ants curved; dist 20
path	51.29,44.72	53.48,47.10	55.33,46.17	57.48,48.07	58.96,47.63
path	60.75,46.43	62.24,44.62	63.57,45.94	63.27,49.13	61.69,55.00
path	61.88,58.44	62.94,65.32	61.88,68.70	62.74,70.12	63.61,72.54
path	61.39,75.80	59.53,76.20	60.04,79.61	59.47,82.26	56.81,86.32
path	54.85,86.07	52.40,86.59	50.42,87.94	48.11,87.57	44.00,86.02
path	41.14,82.82	42.54,77.20	43.81,73.09	42.57,70.49	41.77,66.08
path	42.23,61.68	42.51,57.62	43.63,55.03	43.45,50.95	41.83,49.60
path	41.89,45.46	45.18,40.98	45.64,38.42	48.07,39.13	50.82,41.52
Kill Dread enemies around this area
collect Buzzard Wing##3404 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Rockscale Cod",{
author="support@zygorguides.com",
},[[
step
Fish in the Open Water
collect Raw Rockscale Cod##6362 |n |goto Stranglethorn Vale 26.22,73.57
|tip You will need level 130 Fishing to catch these.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Giant Clam Meat",{
author="support@zygorguides.com",
},[[
step
click Giant Clam##2744+
|tip They look like large shells underwater around this area.
|tip Elixirs of Water Breathing are very helpful while farming these.
collect Giant Clam Meat##4655 |n |goto Stranglethorn Vale 26.75,26.88
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Cooking\\Farming Guides\\Raw Sunscale Salmon",{
author="support@zygorguides.com",
},[[
step
Fish in the Open Water
collect Raw Sunscale Salmon##13760 |n |goto Feralas 62.39,52.49
|tip You will need level 205 Fishing to catch these.
|tip This fish can only be caught during the day; they cannot be caught between midnight and 6 AM server time.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Essence of Water",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Only Plague Ravagers and Blighted Surges will drop this item.
collect Essence of Water##7080 |n |goto Eastern Plaguelands 61.65,81.13
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Living Essence",{
author="support@zygorguides.com",
},[[
step
Kill Tar enemies around this area
collect Living Essence##12803 |n |goto Un'Goro Crater 46.46,17.23
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Essence of Fire",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Un'Goro Crater 52.06,42.40 < 10 |only if walking
Kill enemies around this area
collect Essence of Fire##7078 |n |goto 49.32,48.31
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Essence of Air",{
author="support@zygorguides.com",
},[[
step
kill Dust Stormer##11744+
collect Essence of Air##7082 |n |goto Silithus 31.69,18.15
|tip These have a low drop rate.
You can find more around [21.34,29.92]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Essence of Earth",{
author="support@zygorguides.com",
},[[
step
kill Desert Rumbler##11746+
collect Essence of Earth##7076 |n |goto Silithus 22.37,11.12
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Essence of Undeath",{
author="support@zygorguides.com",
},[[
step
Follow the path |goto Western Plaguelands 56.61,78.55 < 10 |only if walking
Continue following the path |goto 68.58,80.14 < 10 |only if walking
Run up the stairs |goto 69.94,74.00 < 7 |only if walking
Enter the building |goto Eastern Kingdoms 52.79,26.43 < 7 |walk
click Scholomance Door |goto 52.75,26.41 < 5 |walk
Enter the Scholomance dungeon |goto 52.70,26.38 < 5 |c
step
Kill enemies throughout the dungeon
collect Essence of Undeath##12808 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Heart of the Wild",{
author="support@zygorguides.com",
},[[
step
Enter the cave |goto Western Plaguelands 64.78,38.69 < 5 |walk
Kill enemies around this area
|tip Inside the cave.
|tip Rotting Behemoths and Decaying Horrors can drop Heart of the Wild.
|tip The enemies share spawn points, so killing the oozes will spawn more elemental enemies.
collect Heart of the Wild##10286 |n |goto 61.43,36.20
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Ichor of Undeath",{
author="support@zygorguides.com",
},[[
step
Kill Highborne enemies around this area
collect Ichor of Undeath##7972 |n |goto Winterspring 52.59,40.68
|tip These have a low drop rate.
You can find more around: |notinsticky
[53.62,42.09]
[56.02,44.24]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Heart of Fire",{
author="support@zygorguides.com",
},[[
step
Kill Entropic enemies around this area
collect Heart of Fire##7077 |n |goto Felwood 40.92,40.34
|tip These have a low drop rate.
You can find more around [42.51,37.87]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Globe of Water",{
author="support@zygorguides.com",
},[[
step
kill Toxic Horror##7132+
collect Globe of Water##7079 |n |goto Felwood 49.48,23.46
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Core of Earth",{
author="support@zygorguides.com",
},[[
step
kill Desert Rumbler##11746+
collect Core of Earth##7075 |n |goto Silithus 22.94,12.29
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Breath of Wind",{
author="support@zygorguides.com",
},[[
step
kill Dust Stormer##11744+
collect Breath of Wind##7081 |n |goto Silithus 31.69,18.15
|tip These have a low drop rate.
You can find more around [21.34,29.92]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Elemental Fire",{
author="support@zygorguides.com",
},[[
step
kill Burning Exile##2760+
collect Elemental Fire##7068 |n |goto Arathi Highlands 24.80,29.95
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Elemental Earth",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Badlands 46.37,77.20
kill Rock Elemental##92+
collect Elemental Earth##7067 |n |goto 43.30,84.24
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Elemental Water",{
author="support@zygorguides.com",
},[[
step
kill Cresting Exile##2761+
collect Elemental Water##7070 |n |goto Arathi Highlands 66.70,29.91
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Elements\\Farming Guides\\Elemental Air",{
author="support@zygorguides.com",
},[[
step
kill Thundering Exile##2762+
collect Elemental Air##7069 |n |goto Arathi Highlands 52.03,50.77
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Strange Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 5-20 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Small Glimmering Shards instead of Strange Dust.
collect Strange Dust##10940 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Lesser Magic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 3-12 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Strange Dust instead of Lesser Magic Essence.
collect Lesser Magic Essence##10938 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Greater Magic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 9-21 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Strange Dust instead of Greater Magic Essence.
|tip You can turn 3 Lesser Magic Essences into a Greater Magic Essence.
collect Greater Magic Essence##10939 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Lesser Eternal Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 40-50 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Dream Dust instead of Lesser Eternal Essence.
collect Lesser Eternal Essence##16202 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Greater Eternal Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-60 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Illusion Dust instead of Greater Eternal Essence.
|tip You can turn 3 Lesser Eternal Essences into a Greater Eternal Essence.
collect Greater Eternal Essence##16203 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Small Brilliant Shard",{
author="support@zygorguides.com",
},[[
step
Disenchant level 38-50 blue and green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Dream Dust instead of Small Brilliant Shards.
collect Small Brilliant Shard##14343 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Large Brilliant Shard",{
author="support@zygorguides.com",
},[[
step
Disenchant level 50-58 blue weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may very rarely get Nexus Crystals instead of Large Brilliant Shards.
collect Large Brilliant Shard##14344 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Illusion Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-60 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Greater Eternal Essence instead of Illusion Dust.
collect Illusion Dust##16204 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Lesser Astral Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 20-25 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Astral Essence##10998 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Greater Astral Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 20-30 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Astral Essence##11082 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Soul Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 25-35 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Soul Dust##11083 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Lesser Mystic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 30-35 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Mystic Essence##11134 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Greater Mystic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 35-40 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Mystic Essence##11135 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Vision Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 35-45 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Vision Dust##11137 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Lesser Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 40-45 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Nether Essence##11174 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Greater Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-50 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Nether Essence##11175 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Dream Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-55 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Dream Dust##11176 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Greater Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-50 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Nether Essence##11175 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Enchanting\\Farming Guides\\Lesser Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 40-45 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Nether Essence##11174 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Green Whelp Scale",{
author="support@zygorguides.com",
},[[
step
Kill Whelp enemies around this area
|tip Skin their corpses.
|tip You will need level 170 Skinning to collect these.
collect Green Whelp Scale##7392 |n |goto Swamp of Sorrows 13.29,64.20
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Black Whelp Scale",{
author="support@zygorguides.com",
},[[
step
kill Black Dragon Whelp##441+
|tip Skin their corpses.
|tip You will need level 70 Skinning to collect these.
collect Black Whelp Scale##7286 |n |goto Redridge Mountains 34.85,69.67
You can find more around: |notinsticky
[29.64,74.26]
[46.74,77.01]
[57.29,75.08]
[66.62,76.17]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Ruined Leather Scraps",{
author="support@zygorguides.com",
},[[
step
kill Stonetusk Boar##113+
|tip Skin their corpses.
collect Ruined Leather Scraps##2934 |n |goto Elwynn Forest 41.58,86.96
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Light Leather",{
author="support@zygorguides.com",
},[[
step
kill Stonetusk Boar##113+
|tip Skin their corpses.
collect Light Leather##2318 |n |goto Elwynn Forest 41.58,86.96
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Thin Kodo Leather",{
author="support@zygorguides.com",
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	48.32,63.77	46.77,67.86	47.33,72.51	48.23,76.23	48.03,80.88
path	44.76,80.45	44.63,73.81	45.67,69.12	45.20,64.63	46.23,61.11
Kill Kodo enemies as you follow the path around this area
|tip They walk in packs around this area.
|tip Thunderheads and Stormhides won't drop this item.
collect Thin Kodo Leather##5082 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Light Hide",{
author="support@zygorguides.com",
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	48.32,63.77	46.77,67.86	47.33,72.51	48.23,76.23	48.03,80.88
path	44.76,80.45	44.63,73.81	45.67,69.12	45.20,64.63	46.23,61.11
Kill enemies as you follow the path around this area
|tip Only beast enemies will be skinnable.
|tip Skin their corpses.
|tip You will need level 100 Skinning to collect these.
collect Light Hide##783 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Slimy Murloc Scale",{
author="support@zygorguides.com",
},[[
step
Kill Vile Fin enemies around this area
collect Slimy Murloc Scale##5784 |n |goto Silverpine Forest 78.30,30.76
You can find more around: |notinsticky
[80.06,28.45]
[73.54,17.09]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Medium Leather",{
author="support@zygorguides.com",
},[[
step
Kill Yeti enemies around this area
|tip Skin their corpses.
|tip You can find more inside the cave.
|tip You will need level 155 Skinning to collect these.
collect Medium Leather##2319 |n |goto Hillsbrad Foothills 46.12,31.76
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Medium Hide",{
author="support@zygorguides.com",
},[[
step
kill Blackened Basilisk##4044+
|tip Skin their corpses.
|tip You will need level 115 Skinning to collect these.
collect Medium Hide##4232 |n |goto Stonetalon Mountains 44.88,41.82
|tip These have a low drop rate.
You can find more around [36.49,48.50]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Heavy Leather",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Only beast enemies will be skinnable.
|tip Skin their corpses.
|tip You will need level 185 Skinning to collect these.
collect Heavy Leather##4234 |n |goto Dustwallow Marsh 40.73,58.37
You can find more around: |notinsticky
[43.35,50.06]
[40.42,41.57]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Raptor Hide",{
author="support@zygorguides.com",
},[[
step
Kill Highland enemies around this area
collect Raptor Hide##4461 |n |goto Arathi Highlands 52.39,67.61
You can find more around [47.28,78.85]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Heavy Hide",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Skin their corpses.
|tip You will need level 205 Skinning to collect these.
collect Heavy Hide##4235 |n |goto The Hinterlands 16.19,50.97
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Turtle Scale",{
author="support@zygorguides.com",
},[[
step
kill Steeljaw Snapper##14123+
|tip Skin their corpses.
|tip You will need level 210 Skinning to collect these.
collect Turtle Scale##8167 |n |goto Tanaris 67.22,25.77
You can find more around: |notinsticky
[67.57,28.82]
[67.85,35.25]
[68.10,39.75]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Thick Murloc Scale",{
author="support@zygorguides.com",
},[[
step
Kill Mirefin enemies around this area
collect Thick Murloc Scale##5785 |n |goto Dustwallow Marsh 58.78,9.45
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Thick Leather",{
author="support@zygorguides.com",
},[[
step
Kill Ravasaur enemies around this area
|tip Skin their corpses.
|tip You will need level 250 Skinning to collect these.
collect Thick Leather##4304 |n |goto Un'Goro Crater 67.37,72.59
You can find more around: |notinsticky
[65.75,64.16]
[70.21,55.33]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Thick Hide",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Only beast enemies will be skinnable.
|tip Skin their corpses.
|tip You will need level 245 Skinning to collect these.
collect Thick Hide##8169 |n |goto Un'Goro Crater 67.37,72.59
|tip These have a low drop rate.
You can find more around: |notinsticky
[65.75,64.16]
[70.21,55.33]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Worn Dragonscale",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Skin their corpses.
|tip You will need level 205 Skinning to collect these.
collect Worn Dragonscale##8165 |n |goto Dustwallow Marsh 44.75,66.19
|tip These have a low drop rate.
You can find more around [44.71,74.76]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Scorpid Scale",{
author="support@zygorguides.com",
},[[
step
Kill Scorpid enemies around this area
|tip Skin their corpses.
|tip You will need level 215 Skinning to collect these.
collect Scorpid Scale##8154 |n |goto Tanaris 50.93,42.32
You can find more around: |notinsticky
[50.33,48.18]
[44.99,44.85]
[39.08,34.58]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Devilsaur Leather",{
author="support@zygorguides.com",
},[[
step
Kill Devilsaur enemies around this area
|tip Skin their corpses.
|tip These are level 54-56 Elite enemies.
|tip It is recommended you clear the area of other enemies before fighting the Devilsaur.
|tip You will need level 270 Skinning to collect these.
collect Devilsaur Leather##15417 |n |goto Un'Goro Crater 34.25,38.82
You can find more around: |notinsticky
[40.02,62.25]
[57.66,70.17]
[71.30,51.78]
[68.80,26.05]
[31.30,25.52]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Rugged Leather",{
author="support@zygorguides.com",
},[[
step
Kill Ice Thistle enemies around this area
|tip You can find more inside the cave.
|tip Skin their corpses.
|tip You will need level 275 Skinning to collect these.
collect Rugged Leather##8170 |n |goto Winterspring 66.43,44.38
You can find more inside the cave at [67.67,41.72]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Warbear Leather",{
author="support@zygorguides.com",
},[[
step
kill Diseased Grizzly##1816+
|tip Skin their corpses.
|tip You will need level 275 Skinning to collect these.
collect Warbear Leather##15419 |n |goto Western Plaguelands 56.81,63.63
|tip These have a low drop rate.
You can find more around: |notinsticky
[58.69,58.24]
[57.20,52.78]
[61.55,52.23]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Green Dragonscale",{
author="support@zygorguides.com",
},[[
step
map Swamp of Sorrows
path follow smart; loop on; ants curved; dist 20
path	62.18,45.70	59.82,53.60	60.80,60.65	64.62,64.44	68.89,66.20
path	74.52,68.02	79.17,61.93	80.05,53.73	76.69,40.89	70.03,38.01
path	63.28,40.82
Kill Dragonkin enemies around this area as you follow the path
|tip Any Scalebane, Wyrmkin, Green or Dragonkin enemy.
|tip Skin their corpses.
|tip You will need level 205 Skinning to collect these.
collect Green Dragonscale##15412 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Blue Dragonscale",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Any Draconic or Blue enemy.
|tip These are level 50-54 Elite enemies.
|tip Skin their corpses.
|tip You will need level 250 Skinning to collect these.
collect Blue Dragonscale##15415 |n |goto Azshara 36.21,75.55
|tip These have a low drop rate.
You can find more around: |notinsticky
[41.63,77.37]
[42.89,82.91]
[39.79,83.98]
[37.50,80.60]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Rugged Hide",{
author="support@zygorguides.com",
},[[
step
Kill Ice Thistle enemies around this area
|tip You can find more inside the cave.
|tip Skin their corpses.
|tip You will need level 275 Skinning to collect these.
collect Rugged Hide##8171 |n |goto Winterspring 66.43,44.38
|tip These have a low drop rate.
You can find more inside the cave at [67.67,41.72]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Black Dragonscale",{
author="support@zygorguides.com",
},[[
step
Kill enemies around this area
|tip Most of the enemies around this area are Elite.
|tip Skin their corpses.
|tip You will need level 260 Skinning to collect these.
collect Black Dragonscale##15416 |n |goto Burning Steppes 91.30,35.07
|tip These have a low drop rate.
You can find more around [90.73,53.59]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Heavy Scorpid Scale",{
author="support@zygorguides.com",
},[[
step
Kill Stonelash enemies around this area
|tip Skin their corpses.
|tip You will need level 270 Skinning to collect these.
collect Heavy Scorpid Scale##15408 |n |goto Silithus 31.40,38.23
You can find more around: |notinsticky
[26.71,43.66]
[34.12,45.88]
[39.13,52.28]
[42.85,58.57]
[47.97,61.32]
[46.67,70.30]
[45.02,83.62]
[40.32,81.44]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Core Leather",{
author="support@zygorguides.com",
},[[
step
Enter the Molten Core Raid:
Kill Ancient Core Hounds and Magmadar
|tip They are trash mobs found throughout the raid and the second raid boss.
|tip Skin their corpses.
|tip Level 61's require 305 Skinning, level 62's require 310 Skinning, and bosses require 315 Skinning.
collect Core Leather##17012 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Scale of Onyxia",{
author="support@zygorguides.com",
},[[
step
Enter the Onyxia's Lair Raid:
kill Onyxia##10184
|tip Skin its corpse.
|tip You will need level 315 Skinning to collect these.
collect Scale of Onyxia##15410 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Red Dragonscale",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Wetlands 74.18,47.32 < 20 |only if walking
Kill Dragonkin enemies around this area
|tip These are level 57-62 Elite enemies.
|tip Skin their corpses.
|tip You will need level 300 Skinning to collect these.
|tip Level 61's require 305 Skinning and level 62's require 310 Skinning.
collect Red Dragonscale##15414 |n |goto 86.54,51.83
|tip These have a low drop rate.
You can find more around: |notinsticky
[87.95,64.81]
[82.51,70.50]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Primal Bat Leather",{
author="support@zygorguides.com",
},[[
step
Primal Bat Leather is currently unobtainable in Classic
It is dropped from High Priestess Jeklik in the Zul�Gurub raid
Zul�Gurub will not be added to Classic until Phase 4
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Primal Tiger Leather",{
author="support@zygorguides.com",
},[[
step
Primal Tiger Leather is currently unobtainable in Classic
It is dropped from High Priest Thekal in the Zul�Gurub raid
Zul�Gurub will not be added to Classic until Phase 4
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Leather\\Farming Guides\\Dreamscale",{
author="support@zygorguides.com",
},[[
step
Dreamscale is currently unobtainable in Classic
They are dropped from the four Green Dragon world bosses
They will not be added to Classic until Phase 4
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Righteous Orb",{
author="support@zygorguides.com",
},[[
step
Enter the Stratholme Dungeon
|tip You will need to join and form a group for this.
Click Here Once You Have Entered the Dungeon |confirm
step
Make your way to the Crusaders' Square
|tip It will be to the left of the rat gate.
Kill Crimson enemies around this area
|tip All Crimson enemies in The Scarlet Bastion have a chance to drop the orb.
collect Righteous Orb##12811 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Demonic Rune",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Felwood 38.44,59.39 < 20 |only if walking
Continue following the path |goto 37.63,60.96 < 20 |only if walking
Continue following the path |goto 36.04,61.32 < 20 |only if walking
Enter the building |goto 35.39,58.61 < 20 |walk
Kill Jaedenar enemies around this area
collect Demonic Rune##12662 |n |goto 37.61,54.67
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Dark Rune",{
author="support@zygorguides.com",
},[[
step
Enter the Scholomance Dungeon
|tip You will need to join and form a group for this.
Click Here Once You Have Entered the Dungeon |confirm
step
Kill enemies around this area
|tip Scholomance Necromancers and Scholomance Dark Summoners are the only enemies besides bosses that will drop them.
collect Dark Rune##20520 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Sharp Claw",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Wetlands 66.98,40.59 < 20 |only if walking
Continue up the path |goto 67.64,39.88 < 20 |only if walking
Enter the cave |goto 69.33,34.86 < 20 |walk
Kill Razormaw enemies around this area
|tip Inside the cave.
collect Sharp Claw##5635 |n |goto 70.42,29.50
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Ogre Tannin",{
author="support@zygorguides.com",
},[[
step
Enter the Dire Maul West Dungeon Entrance
|tip You will need to join and form a group for this.
Click Here Once You Have Entered the Dungeon |confirm
step
click Ogre Tannin Basket##179499
|tip It will be up the ramp past the broken trap.
|tip Once up the first ramp, it will be in the far northwest corner of the room.
|tip Only one person will be able to loot it.
collect Ogre Tannin##18240 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Small Venom Sac",{
author="support@zygorguides.com",
},[[
step
map Redridge Mountains
path follow smart; loop on; ants curved; dist 20
path	51.04,41.76	53.70,43.86	53.45,46.07	55.68,47.30	57.57,44.98
path	55.62,41.71	53.83,37.42	51.30,38.07
Kill tarantula enemies around this area
collect Small Venom Sac##1475 |n
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Huge Venom Sac",{
author="support@zygorguides.com",
},[[
step
map Silithus
path follow smart; loop on; ants curved; dist 20
path	54.03,30.39	56.79,33.30	59.06,30.91	61.29,30.65	63.54,31.68
path	66.19,30.35	65.86,26.61	64.78,22.29	63.17,18.92	61.66,15.66
path	60.22,13.51	58.24,13.36	56.02,11.72	54.46,13.22	52.99,12.72
path	51.43,13.97	49.68,16.23	51.34,19.02	51.78,22.20	52.37,25.34
path	52.30,29.17	52.30,29.17
Kill enemies around this area
collect Huge Venom Sac##19441 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Iridescent Pearl",{
author="support@zygorguides.com",
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	15.21,40.13	17.36,39.06	19.36,38.16	22.88,37.14	24.91,36.76
path	24.41,33.77	23.10,33.59	21.34,34.34	19.64,31.98	18.24,31.36
path	16.84,29.42	15.14,30.74	14.96,33.33	14.32,35.71	13.91,38.13
path	14.03,40.90
Kill Bluegill enemies around this area
collect Thick-shelled Clam##5524 |n
use the Thick-shelled Clam##5524
collect Iridescent Pearl##5500 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Black Pearl",{
author="support@zygorguides.com",
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	77.17,61.30	76.67,63.69	75.25,66.52	74.76,70.67	76.93,70.62
path	78.28,68.54	78.37,65.51	79.09,61.95	80.38,59.45	81.70,56.06
path	81.78,52.32	80.30,55.82	79.00,57.73
Kill Snapjaw enemies around this area
collect Big-mouth Clam##7973 |n
use the Big-mouth Clam##7973
collect Black Pearl##7971 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Golden Pearl",{
author="support@zygorguides.com",
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	77.17,61.30	76.67,63.69	75.25,66.52	74.76,70.67	76.93,70.62
path	78.28,68.54	78.37,65.51	79.09,61.95	80.38,59.45	81.70,56.06
path	81.78,52.32	80.30,55.82	79.00,57.73
Kill Snapjaw enemies around this area
collect Big-mouth Clam##7973 |n
use the Big-mouth Clam##7973
collect Golden Pearl##13926 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Giant Egg",{
author="support@zygorguides.com",
},[[
step
Kill Roc enemies around this area
|tip They are found all around the zone.
collect Giant Egg##12207 |n |goto Tanaris 49.30,36.17
You can find more around: |notinsticky
[45.55,38.57]
[44.01,40.45]
[47.27,46.81]
]])
ZygorGuidesViewer:RegisterGuide("Professions\\Dropped\\Farming Guides\\Zesty Clam Meat",{
author="support@zygorguides.com",
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	77.17,61.30	76.67,63.69	75.25,66.52	74.76,70.67	76.93,70.62
path	78.28,68.54	78.37,65.51	79.09,61.95	80.38,59.45	81.70,56.06
path	81.78,52.32	80.30,55.82	79.00,57.73
Kill Snapjaw enemies around this area
collect Big-mouth Clam##7973 |n
use the Big-mouth Clam##7973
collect Zesty Clam Meat##7974 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Silverleaf, Peacebloom, Earthroot",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=1},levelreq={1,60}},
items={{765,64},{2447,80},{2449,56}},
maps={"Elwynn Forest"},
},[[
step
map Elwynn Forest/0
path follow smart; loop on; ants curved; dist 20
path	35.16,58.15	35.80,61.90	34.96,66.91	35.08,70.72	34.97,74.55
path	31.26,76.29	29.39,72.28	26.34,77.16	26.78,84.53	26.01,88.87
path	28.95,85.90	31.32,84.53	34.00,86.31	35.63,87.61	40.33,90.30
path	42.44,85.05	42.33,79.53	44.78,75.63	57.19,75.30	61.71,78.02
path	64.64,80.21	66.96,82.28	71.53,82.34	74.86,79.96	85.15,82.86
path	88.50,76.38	87.13,70.90	86.64,64.81	83.70,60.88	78.23,58.27
path	74.68,59.68	70.59,61.28	67.25,64.47	63.72,65.35	60.60,62.03
path	56.21,61.31	51.67,60.44	49.08,59.49	44.65,55.81	42.02,54.40
path	39.16,55.56
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 15 Herbalism to collect Earthroot.
collect Silverleaf##765 |n
collect Peacebloom##2447 |n
collect Earthroot##2449 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Mageroyal",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=50},levelreq={10,60}},
items={{785,32},{2447,40}},
maps={"Loch Modan"},
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	40.87,42.34	40.99,35.44	40.38,29.51	40.17,23.46	41.23,14.88
path	41.13,12.44	42.83,10.59	46.36,14.30	49.72,14.09	53.28,10.94
path	55.46,15.29	59.73,16.49	61.91,22.17	63.02,31.38	66.61,41.14
path	67.83,45.31	67.40,49.93	64.11,54.95	62.24,59.85	59.35,63.18
path	54.73,67.89	51.47,69.31	48.03,68.82
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 50 Herbalism to collect these.
collect Mageroyal##785 |n
'|goto 48.03,68.82 < 40 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	48.03,68.82	51.47,69.31	54.73,67.89	59.35,63.18	62.24,59.85
path	64.11,54.95	67.40,49.93	67.83,45.31	66.61,41.14	63.02,31.38
path	61.91,22.17	59.73,16.49	55.46,15.29	53.28,10.94	49.72,14.09
path	46.36,14.30	42.83,10.59	41.13,12.44	41.23,14.88	40.17,23.46
path	40.38,29.51	40.99,35.44	40.87,42.34
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 50 Herbalism to collect these.
collect Mageroyal##785 |n
'|goto 40.87,42.34 < 40 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Stranglekelp",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=85},levelreq={30,60}},
items={{3820,40}},
maps={"Stranglethorn Vale"},
},[[
step
label "Path_One"
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	27.56,22.38	28.55,26.38	30.37,30.98	33.88,33.36	30.36,35.99
path	27.70,38.32	26.24,42.31	26.20,47.90	22.96,47.20	21.86,51.72
path	22.04,55.91	25.74,57.13	23.90,60.72	23.70,64.65	26.18,68.29
path	23.58,75.22	24.21,79.36	25.98,84.41	31.39,83.70	33.23,80.90
path	34.46,76.56	37.38,68.78	38.81,62.94
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip They are underwater along the path.
|tip Bring Water Walking Potions.
|tip You will need level 85 Herbalism to collect these.
collect Stranglekelp##3820 |n
'|goto 38.81,62.94 < 20 |noway |c
step
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	38.81,62.94	37.38,68.78	34.46,76.56	33.23,80.90	31.39,83.70
path	25.98,84.41	24.21,79.36	23.58,75.22	26.18,68.29	23.70,64.65
path	23.90,60.72	25.74,57.13	22.04,55.91	21.86,51.72	22.96,47.20
path	26.20,47.90	26.24,42.31	27.70,38.32	30.36,35.99	33.88,33.36
path	30.37,30.98	28.55,26.38	27.56,22.38
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip They are underwater along the path.
|tip Bring Water Walking Potions.
|tip You will need level 85 Herbalism to collect these.
collect Stranglekelp##3820 |n
'|goto 27.56,22.38 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Briarthorn, Swiftthistle",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=70},levelreq={10,60}},
items={{2450,24},{2452,24},{2447,28},{785,20}},
maps={"Loch Modan"},
},[[
step
map Loch Modan
path follow smart; loop on; ants curved; dist 20
path	50.11,70.98	56.14,64.90	60.73,61.95	63.09,57.29	64.59,43.34
path	58.98,33.49	55.48,28.48	53.87,22.04	57.70,16.70	61.33,17.00
path	63.45,23.61	63.96,28.94	67.27,33.55	71.77,36.88	74.64,31.08
path	76.86,42.55	75.17,53.91	77.54,57.68	77.01,64.32	78.39,70.75
path	76.62,73.82	73.00,71.84	67.09,75.89	58.35,76.95	55.16,77.71
path	51.86,73.52
Click herbs as you follow the path around this area
|tip Briarthorn can share a spawn with other herbs in the area, so pick them all.
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 70 Herbalism to collect these.
collect Briarthorn##2450 |n
collect Swiftthistle##2452 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Bruiseweed",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=100},levelreq={20,60}},
items={{2453,32}},
maps={"Ashenvale"},
},[[
step
label "Bruiseweed_1"
map Ashenvale
path follow smart; loop off; dist 20
path	30.47,44.71	27.77,48.81	25.72,50.64	28.38,54.47	34.66,54.20
path	35.41,56.86	34.85,58.62	32.71,59.66	34.71,59.96	38.06,62.62
path	40.48,61.75	39.97,65.16	41.82,64.95	43.85,63.15	47.09,61.20
path	48.42,60.26	49.98,59.22	54.29,60.93	56.36,63.51	57.82,64.38
path	59.14,70.90	60.56,73.42	69.78,74.49	71.98,73.86	74.94,73.92
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 100 Herbalism to collect these.
collect Bruiseweed##2453 |n
'|goto 74.94,73.92 < 20 |noway |c
step
map Ashenvale
path follow smart; loop off; dist 20
path	74.94,73.92	71.98,73.86	69.78,74.49	60.56,73.42	59.14,70.90
path	57.82,64.38	56.36,63.51	54.29,60.93	49.98,59.22	48.42,60.26
path	47.09,61.20	43.85,63.15	41.82,64.95	39.97,65.16	40.48,61.75
path	38.06,62.62	34.71,59.96	32.71,59.66	34.85,58.62	35.41,56.86
path	34.66,54.20	28.38,54.47	25.72,50.64	27.77,48.81	30.47,44.71
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 100 Herbalism to collect these.
collect Bruiseweed##2453 |n
'|goto 30.47,44.71 < 20 |noway |c |next "Bruiseweed_1"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Wild Steelbloom",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=115},levelreq={30,60}},
items={{3355,40}},
maps={"Stranglethorn Vale"},
},[[
step
map Stranglethorn Vale
path follow smart; loop on; ants curved; dist 20
path	35.19,24.89	34.15,16.96	32.35,17.29	29.81,16.22	28.04,17.47
path	25.80,17.04	23.47,14.43	23.84,13.79	26.85,13.53	26.47,10.74
path	26.96,10.08	26.83,8.41	28.93,7.53	31.07,9.11	33.66,7.50
path	35.36,6.91	37.47,8.17	40.26,7.17	42.31,8.80	43.43,9.07
path	44.02,6.96	46.87,7.20	49.23,10.26	46.15,12.93	46.18,15.78
path	48.55,20.93	49.87,26.32	48.46,42.77	46.45,44.95	42.29,44.37
path	39.61,44.79	38.13,35.79
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 115 Herbalism to collect these.
collect Wild Steelbloom##3355 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Grave Moss",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=120},levelreq={20,60}},
items={{3369,16}},
maps={"Wetlands"},
},[[
step
Click herbs around this area
|tip Track them on your minimap with "Find Herbs".
|tip They spawn in this small area.
|tip You will need level 120 Herbalism to collect these.
collect Grave Moss##3369 |n |goto Wetlands 44.07,26.40
You can find more inside the crypt at [44.27,25.39]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Kingsblood",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=125},levelreq={20,60}},
items={{3356,48}},
maps={"Wetlands"},
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	46.75,25.55	51.58,29.02	56.21,30.36	59.67,33.23	62.46,34.02
path	61.92,38.94	58.55,43.68	56.51,48.27	44.88,34.82	41.25,33.98
path	35.44,31.57	31.52,36.24	26.99,34.94	18.37,36.35	13.78,37.41
path	14.84,33.80	18.22,32.79	19.10,26.35	21.55,27.19	24.28,28.73
path	27.93,30.36	32.61,27.99	35.45,24.60	38.43,23.41	40.84,24.23
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 125 Herbalism to collect these.
collect Kingsblood##3356 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Liferoot",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=150},levelreq={20,60}},
items={{3357,20}},
maps={"Wetlands"},
},[[
step
label "Path_One"
map Wetlands
path follow smart; loop off; dist 20
path	39.88,29.56	42.39,32.16	44.42,36.02	50.85,37.60	53.92,41.52
path	55.96,45.32	59.97,50.83	61.97,56.83	64.42,68.06	63.29,74.88
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 150 Herbalism to collect these.
collect Liferoot##3357 |n
'|goto 63.29,74.88 < 20 |noway |c
step
map Wetlands
path follow smart; loop off; dist 20
path	63.29,74.88	64.42,68.06	61.97,56.83	59.97,50.83	55.96,45.32
path	53.92,41.52	50.85,37.60	44.42,36.02	42.39,32.16	39.88,29.56
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 150 Herbalism to collect these.
collect Liferoot##3357 |n
'|goto 39.88,29.56 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Fadeleaf",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=160},levelreq={20,60}},
items={{3818,60}},
maps={"Swamp of Sorrows"},
},[[
step
map Swamp of Sorrows
path follow smart; loop on; ants curved; dist 20
path	20.50,54.53	16.62,58.22	15.71,65.71	12.68,68.05	10.73,63.62
path	12.41,55.83	15.50,47.83	18.39,45.92	22.07,39.95	28.92,38.70
path	33.28,38.90	38.62,34.97	47.12,33.93	51.82,34.91	51.62,41.06
path	44.78,45.30	37.49,50.34	33.07,52.19	27.05,54.68	22.47,57.13
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip Watch out for horde guards along the main road.
|tip You will need level 160 Herbalism to collect these.
collect Fadeleaf##3818 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Goldthorn, Khadgar's Whisker",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=170},levelreq={30,60}},
items={{3821,60},{3358,32}},
maps={"Stranglethorn Vale"},
},[[
step
label "Path_One"
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	30.73,67.93	31.34,65.94	31.29,63.30	33.47,59.16	34.72,58.50
path	35.99,56.40	34.16,54.11	33.67,52.84	34.22,50.55	35.98,48.96
path	36.98,48.70	39.98,44.91	40.43,43.96	40.36,42.07	41.34,40.39
path	43.07,37.30	43.31,39.18	43.52,40.25	44.37,39.85	44.49,41.37
path	44.53,43.67	45.58,43.90	46.54,43.36	47.13,43.87	47.84,42.42
path	47.79,40.43	49.03,37.60	48.82,36.22	49.70,31.42	49.45,29.64
path	50.03,27.63	50.56,26.44	49.98,23.97	47.47,22.67	46.33,24.57
path	44.74,25.50	43.42,26.50	40.87,28.82	40.14,32.21	38.73,33.10
path	36.97,34.22	36.66,38.10	36.42,41.03	34.95,40.76	33.81,39.53
path	31.73,42.03	30.29,43.54	28.79,44.84	28.04,47.89	27.69,50.35
path	29.34,52.92	29.92,54.14	31.79,52.55
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 170 Herbalism to collect these.
collect Goldthorn##3821 |n
collect Khadgar's Whisker##3358 |n
'|goto 31.79,52.55 < 20 |noway |c
step
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	33.43,55.29	33.15,56.95	31.66,58.87	31.13,61.25	30.56,63.99
path	30.40,67.21
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 170 Herbalism to collect these.
collect Goldthorn##3821 |n
collect Khadgar's Whisker##3358 |n
'|goto 30.40,67.21 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Wintersbite",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=195},levelreq={30,60}},
items={{3819,40}},
maps={"Alterac Mountains"},
},[[
step
label "Path_One"
map Alterac Mountains
path follow smart; loop off; dist 20
path	36.21,70.12	38.50,71.59	42.34,67.24	40.46,63.73	45.07,62.49
path	49.57,60.07	50.10,56.20	49.14,51.29	45.91,45.67	47.02,42.14
path	46.73,38.06	44.90,32.01
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 195 Herbalism to collect these.
collect Wintersbite##3819 |n
'|goto 44.90,32.01 < 20 |noway |c
step
map Alterac Mountains
path follow smart; loop off; dist 20
path	44.90,32.01	46.73,38.06	47.02,42.14	45.91,45.67	49.14,51.29
path	50.10,56.20	49.57,60.07	45.07,62.49	40.46,63.73	42.34,67.24
path	38.50,71.59	36.21,70.12
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 195 Herbalism to collect these.
collect Wintersbite##3819 |n
'|goto 36.21,70.12 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Wildvine",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=210},levelreq={45,60}},
items={{8153,20}},
maps={"The Hinterlands"},
},[[
step
Kill Vilebranch Enemies around this area
collect Wildvine##8153 |n |goto The Hinterlands 47.57,66.46
|tip They have a 10% chance to be gathered from Purple Lotus around the Altar.
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 210 Herbalism to collect these.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Firebloom",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=205},levelreq={45,60}},
items={{4625,60}},
maps={"Blasted Lands"},
},[[
step
map Blasted Lands
path follow smart; loop on; ants curved; dist 20
path	59.95,26.91	63.87,32.24	62.52,37.16	61.93,40.77	63.59,47.87
path	60.16,47.06	56.61,47.07	52.58,50.11	48.61,51.34	45.83,49.50
path	46.56,43.37	45.38,37.03	44.55,26.43	45.95,23.01	49.76,23.71
path	51.28,26.22	52.49,31.62	51.40,36.19	53.41,38.07	55.97,36.24
path	57.46,32.43	58.67,28.99
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 205 Herbalism to collect these.
collect Firebloom##4625 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Purple Lotus",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=210},levelreq={45,60}},
items={{8831,48}},
maps={"Azshara"},
},[[
step
map Azshara
path follow smart; loop on; ants curved; dist 20
path	13.44,76.03	13.49,73.41	13.96,72.13	15.04,72.61	16.67,72.10
path	18.11,69.50	19.30,63.70	19.72,61.12	21.39,60.74	24.79,58.76
path	25.63,56.77	25.97,53.77	24.66,50.64	25.95,49.40	27.49,50.93
path	29.47,52.59	30.30,54.30	32.31,55.35	32.55,57.96	31.89,60.78
path	34.71,61.62	35.79,60.81	36.20,59.43	36.50,57.60	38.27,56.97
path	38.93,60.17	38.62,62.10	37.62,63.76	37.16,67.40	36.65,71.52
path	36.55,73.48	35.12,76.04	32.98,79.88	31.50,80.61	28.68,80.41
path	25.35,79.42	24.06,79.46	19.93,77.32	18.50,79.02	16.39,79.69
path	14.67,79.40
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 210 Herbalism to collect these.
collect Purple Lotus##8831 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Arthas' Tears",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=220},levelreq={50,60}},
items={{8836,20}},
maps={"Western Plaguelands"},
},[[
step
map Western Plaguelands
path follow smart; loop on; ants curved; dist 20
path	38.46,71.59	40.21,70.25	41.92,68.36	43.65,67.66	43.55,64.99
path	42.58,61.73	44.99,61.15	45.83,59.71	47.54,60.16	48.88,62.22
path	50.20,63.25	51.12,65.36	51.20,68.70	52.77,69.69	54.81,66.60
path	55.29,62.85	56.78,59.81	58.67,58.12	58.67,58.12	61.36,51.95
path	59.63,51.59	56.24,51.02	55.02,49.73	53.44,46.46	51.12,44.12
path	49.07,42.44	46.93,39.92	46.45,37.04	47.66,35.14	49.62,33.23
path	48.75,31.25	48.00,31.04	46.53,31.70	44.60,32.62	43.64,35.30
path	44.60,37.79	45.12,41.59	45.73,46.00	45.79,47.79	43.94,50.26
path	40.48,52.81	39.18,52.53	38.68,53.52	35.80,54.28	34.28,55.75
path	33.16,57.76	33.14,59.71	32.83,61.21	33.06,63.79	34.28,66.60
path	36.12,68.62	37.31,71.53
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 220 Herbalism to collect these.
collect Arthas' Tears##8836 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Sungrass, Firebloom",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=230},levelreq={45,60}},
items={{8838,40},{4625,32}},
maps={"Blasted Lands"},
},[[
step
map Blasted Lands
path follow smart; loop on; ants curved; dist 20
path	59.95,26.91	63.87,32.24	62.52,37.16	61.93,40.77	63.59,47.87
path	60.16,47.06	56.61,47.07	52.58,50.11	48.61,51.34	45.83,49.50
path	46.56,43.37	45.38,37.03	44.55,26.43	45.95,23.01	49.76,23.71
path	51.28,26.22	52.49,31.62	51.40,36.19	53.41,38.07	55.97,36.24
path	57.46,32.43	58.67,28.99
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 230 Herbalism to collect these.
collect Sungrass##8838 |n
collect Firebloom##4625 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Blindweed, Fadeleaf",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=235},levelreq={35,60}},
items={{8839,60},{3818,60}},
maps={"Swamp of Sorrows"},
},[[
step
map Swamp of Sorrows
path follow smart; loop on; ants curved; dist 20
path	23.34,47.48	26.00,39.24	28.21,37.10	31.38,35.00	36.11,36.48
path	38.30,35.54	40.98,35.26	42.49,39.06	44.13,40.53	46.07,41.10
path	46.56,38.70	49.85,36.00	52.70,36.48	54.71,36.25	57.38,33.20
path	58.78,30.30	62.57,29.33	66.36,28.36	68.29,25.21	69.20,20.52
path	69.38,15.92	72.73,13.20	76.51,14.32	78.04,18.24	81.03,21.94
path	82.49,25.63	82.43,31.77	82.80,37.29	86.93,38.06	88.09,44.02
path	88.14,49.77	85.09,53.96	86.43,57.71	84.56,62.68	84.28,67.90
path	81.40,71.41	78.10,69.78	76.69,64.12	78.72,58.47	80.88,55.22
path	81.42,48.27	81.70,43.61	79.06,40.69	77.48,38.74	76.64,34.28
path	73.75,33.11	70.93,33.86	68.69,31.71	65.67,35.50	61.30,37.56
path	58.02,38.46	54.71,41.87	53.10,42.33	49.93,42.29	47.27,43.26
path	44.52,45.19	42.66,47.65	39.83,49.22	36.79,51.04	33.83,51.96
path	29.04,54.25
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 235 Herbalism to collect these.
collect Blindweed##8839 |n
collect Fadeleaf##3818 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Ghost Mushroom, Wildvine",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=245},levelreq={45,60}},
items={{8845,28},{8153,20}},
maps={"The Hinterlands"},
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	57.75,46.26	59.21,44.51	59.83,40.90	57.54,38.67	55.82,38.52
path	54.48,40.89	54.34,43.82	55.65,46.02
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 245 Herbalism to collect these.
|tip They spawn inside of the cave along this path as well as outside of it.
collect Ghost Mushroom##8845 |n
collect Wildvine##8153 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Gromsblood, Sungrass, Firebloom",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=250},levelreq={45,60}},
items={{8846,28},{8838,40},{4625,32}},
maps={"Blasted Lands"},
},[[
step
map Blasted Lands
path follow smart; loop on; ants curved; dist 20
path	59.95,26.91	63.87,32.24	62.52,37.16	61.93,40.77	63.59,47.87
path	60.16,47.06	56.61,47.07	52.58,50.11	48.61,51.34	45.83,49.50
path	46.56,43.37	45.38,37.03	44.55,26.43	45.95,23.01	49.76,23.71
path	51.28,26.22	52.49,31.62	51.40,36.19	53.41,38.07	55.97,36.24
path	57.46,32.43	58.67,28.99
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 250 Herbalism to collect these.
collect Gromsblood##8846 |n
collect Sungrass##8838 |n
collect Firebloom##4625 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Golden Sansam, Dreamfoil",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=260},levelreq={45,60}},
items={{13464,40},{13463,28}},
maps={"Azshara"},
},[[
step
map Azshara
path follow smart; loop on; ants curved; dist 20
path	44.97,34.08	45.34,30.56	45.01,27.72	44.00,22.97	44.61,20.55
path	45.91,19.60	48.17,18.74	50.79,18.10	52.77,19.45	53.43,20.10
path	54.10,20.23	56.85,20.66	59.23,18.80	61.89,16.89	64.79,17.01
path	66.41,15.27	69.57,16.37	71.70,16.63	73.96,18.69	75.86,21.19
path	76.87,24.70	79.46,24.05	79.40,26.62	77.14,28.54	74.71,29.28
path	71.72,29.19	69.51,28.09	67.74,26.09	64.29,23.93	61.47,23.67
path	59.32,24.37	56.53,25.81	54.31,28.58	52.61,32.17	49.37,31.47
path	46.94,31.71
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 260 Herbalism to collect these.
collect Golden Sansam##13464 |n
collect Dreamfoil##13463 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Mountain Silversage",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=280},levelreq={50,60}},
items={{13465,20}},
maps={"Un'Goro Crater"},
},[[
step
map Un'Goro Crater
path follow smart; loop on; ants curved; dist 20
path	69.50,80.51	66.73,78.96	62.06,80.45	60.17,83.38	57.90,84.92
path	56.43,85.63	52.59,86.79	50.45,85.64	47.59,86.84	44.06,85.48
path	40.43,83.69	37.58,82.20	36.74,80.02	34.35,78.80	30.60,79.47
path	29.81,78.29	29.45,73.80	29.51,71.95	30.47,70.66	30.12,68.78
path	26.87,68.47	26.22,63.87	24.35,55.86	24.60,51.19	24.66,49.08
path	24.29,47.04	24.87,40.95	26.12,37.25	26.47,32.27	28.16,29.95
path	29.28,30.78	30.53,29.41	29.59,24.96	30.56,20.83	33.11,20.72
path	34.48,21.20	36.41,20.34	38.57,16.60	42.23,16.10	44.74,14.15
path	48.26,13.20	49.78,17.80	51.76,16.54	52.14,13.12	54.40,13.42
path	56.79,14.48	59.79,16.53	62.08,16.53	63.95,19.36	65.85,21.43
path	66.83,23.10	67.79,22.98	68.24,20.16	70.91,20.97	71.45,25.67
path	71.86,28.59	74.60,32.13	74.81,36.14	76.10,40.85	76.77,46.27
path	76.23,50.57	76.85,54.91	75.63,60.70	74.66,64.47	74.30,69.24
path	71.82,70.72	70.92,71.71	71.15,74.12	70.59,75.37	70.92,79.06
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 280 Herbalism to collect these.
collect Mountain Silversage##13465 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Plaguebloom",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=285},levelreq={50,60}},
items={{13466,20},{13463,16}},
maps={"Eastern Plaguelands"},
},[[
step
map Eastern Plaguelands
path follow smart; loop on; ants curved; dist 20
path	63.32,54.67	67.59,55.28	72.06,54.50	75.06,53.69	77.43,53.29
path	78.36,55.80	79.17,59.16	80.07,63.69	80.31,67.80	78.88,71.68
path	76.88,73.45	75.52,74.46	74.76,76.67	72.94,78.41	68.81,75.52
path	66.81,76.30	65.03,73.91	64.71,69.43	63.81,66.25	63.25,64.01
path	63.98,59.07
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 285 Herbalism to collect these.
collect Plaguebloom##13466 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Icecap",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=285},levelreq={50,60}},
items={{13467,28},{13465,12}},
maps={"Winterspring"},
},[[
step
map Winterspring
path follow smart; loop on; ants curved; dist 20
path	51.15,36.38	49.02,37.97	47.29,38.82	46.26,37.85	44.98,36.98
path	43.34,37.35	42.00,36.66	40.04,36.95	37.55,36.29	37.03,38.50
path	37.04,40.67	36.22,41.42	34.89,40.49	32.81,37.93	31.53,36.07
path	29.97,36.02	29.97,39.23	29.90,42.23	30.63,44.36	31.61,44.78
path	32.31,44.29	34.16,43.86	34.79,42.97	35.73,43.41	36.55,44.20
path	37.95,44.18	40.05,43.83	41.97,43.60	43.29,44.09	44.44,42.87
path	45.25,41.37	45.82,40.53	46.38,39.95	47.29,40.48	48.43,42.60
path	49.89,44.73	50.67,45.63	52.44,46.41	53.08,44.56	53.42,43.72
path	55.09,43.38	56.62,42.13	57.86,40.63	58.81,39.07	58.04,36.73
path	56.38,36.22	54.08,33.77
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 290 Herbalism to collect these.
collect Icecap##13467 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Black Lotus",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={herbalism=285},levelreq={50,60}},
items={{13468,4}},
maps={"Burning Steppes"},
},[[
step
label "Path_One"
map Burning Steppes
path follow smart; loop off; dist 20
path	75.56,48.10	67.51,44.35	65.55,42.14	64.07,37.82	63.48,37.82
path	60.30,40.06	49.65,36.46	46.29,34.47	43.06,33.76	41.88,37.36
path	41.46,40.03	42.68,42.14	42.11,43.86	39.76,44.39	35.84,48.89
path	33.34,55.11	31.73,57.80	27.13,61.16	25.14,54.29	22.87,50.09
path	18.10,44.02	15.47,40.51	15.42,34.23	15.35,30.51
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 300 Herbalism to collect these.
collect Black Lotus##13468 |n
|tip These are extremely rare.
|tip Pick other herbs on the path to have a chance to spawn them.
'|goto 15.35,30.51 < 20 |noway |c
step
map Burning Steppes
path follow smart; loop off; dist 20
path	15.35,30.51	15.42,34.23	15.47,40.51	18.10,44.02	22.87,50.09
path	25.14,54.29	27.13,61.16	31.73,57.80	33.34,55.11	35.84,48.89
path	39.76,44.39	42.11,43.86	42.68,42.14	41.46,40.03	41.88,37.36
path	43.06,33.76	46.29,34.47	49.65,36.46	60.30,40.06	63.48,37.82
path	64.07,37.82	65.55,42.14	67.51,44.35	75.56,48.10
Click herbs as you follow the path around this area
|tip Track them on your minimap with "Find Herbs".
|tip You will need level 300 Herbalism to collect these.
collect Black Lotus##13468 |n
|tip These are extremely rare.
|tip Pick other herbs on the path to have a chance to spawn them.
'|goto 75.56,48.10 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Copper Ore, Rough Stone",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={mining=1},levelreq={1,60}},
items={{2770,100},{2835,100}},
maps={"Elwynn Forest"},
},[[
step
map Elwynn Forest
path follow smart; loop on; ants curved; dist 20
path	30.84,52.85	31.66,56.55	30.70,59.27	33.97,61.71	32.67,69.74
path	34.82,71.77	38.65,70.47	41.90,72.73	38.79,78.16	36.73,83.14
path	38.86,85.10	40.47,81.19	42.54,75.73	43.46,72.43	45.88,71.66
path	48.66,72.57	50.67,73.61	52.16,76.22	51.59,81.68	50.51,84.27
path	52.44,85.57	54.07,81.63	55.50,80.65	57.18,77.77	59.76,76.99
path	64.90,71.42	66.82,69.10	70.81,68.32	75.97,68.43	74.95,64.93
path	73.11,60.29	76.43,54.83	77.84,50.88	75.35,46.25	73.10,46.01
path	71.20,49.01	71.93,55.39	68.33,54.29	67.11,57.66	65.88,58.62
path	65.45,55.47	63.86,53.92	61.15,54.32	59.49,56.50	57.71,57.94
path	55.65,58.04	53.51,57.94	52.34,58.34	51.04,58.74	49.28,57.01
path	50.05,53.17	48.15,51.19	47.15,49.29	43.66,49.22	41.39,51.02
path	39.84,53.01	36.99,52.64	34.92,51.69	35.76,48.57	34.85,46.74
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
collect Copper Ore##2770 |n
collect Rough Stone##2835 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Tin Ore, Silver Ore, Coarse Stone, Moss Agate",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={mining=65},levelreq={15,60}},
items={{2771,60},{2775,4},{2836,24},{1206,2},{2770,16}},
maps={"Wetlands"},
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	34.74,16.82	36.33,18.75	39.75,20.23	43.44,23.27	46.05,22.77
path	48.20,23.86	49.91,23.03	53.21,23.66	55.80,22.78	57.30,23.64
path	58.74,23.33	60.36,21.58	61.25,24.78	63.07,26.13	64.55,28.11
path	63.58,30.34	64.11,33.78	65.20,39.01	67.23,42.83	71.03,45.91
path	70.92,50.14	67.86,53.66	67.02,56.69	66.31,60.65	66.18,65.59
path	67.37,73.31	59.48,72.47	57.49,74.14	56.16,78.29	54.13,78.16
path	54.29,74.22	54.19,68.98	56.08,60.41	56.30,58.46	55.28,53.86
path	53.93,48.40	52.05,43.80	48.11,40.65	44.62,39.47	42.08,40.16
path	38.66,37.95	34.42,38.78
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 65 Mining to collect Tin Ore and 75 to collect Silver Ore.
collect Tin Ore##2771 |n
collect Silver Ore##2775 |n
collect Coarse Stone##2836 |n
collect Moss Agate##1206 |n
|tip These are a rare drop from Tin and Silver Ore nodes.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Iron Ore, Gold Ore, Heavy Stone",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={mining=125},levelreq={30,60}},
items={{2772,100},{2776,12},{2838,80}},
maps={"Arathi Highlands"},
},[[
step
map Arathi Highlands
path follow smart; loop on; ants curved; dist 20
path	76.64,42.59	75.00,44.93	72.65,48.07	70.58,55.05	69.99,58.40
path	72.92,59.03	72.28,63.63	72.78,66.86	71.75,66.15	69.15,72.54
path	67.17,70.90	63.52,73.55	59.48,74.71	59.32,70.74	56.16,71.89
path	50.82,78.41	47.96,82.44	42.53,80.75	43.02,77.16	40.39,71.86
path	37.95,67.63	38.52,68.50	33.94,66.02	34.59,61.64	33.70,56.77
path	33.45,53.94	33.65,50.19	35.00,47.28	32.96,46.68	31.68,45.41
path	32.34,42.64	31.42,41.24	25.23,43.10	20.94,39.12	20.02,35.80
path	19.12,33.36	22.43,31.28	23.48,24.90	26.93,20.65	28.65,14.18
path	28.96,16.96	31.62,18.63	30.96,20.36	33.19,21.23	36.35,24.61
path	39.97,25.62	40.21,28.79	43.97,30.51	45.70,33.02	48.08,33.60
path	49.78,36.76	52.14,36.11	52.75,31.99	54.80,33.13	58.19,32.50
path	58.02,34.22	59.94,35.97	62.25,32.06	64.69,35.58	64.49,26.56
path	66.77,27.64	70.39,27.07	70.47,30.74	71.07,38.63
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 125 Mining to collect Iron Ore and 155 to collect Gold Ore.
collect Iron Ore##2772 |n
collect Gold Ore##2776 |n
collect Heavy Stone##2838 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Mithril Ore, Truesilver Ore, Solid Stone",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={mining=175},levelreq={40,60}},
items={{3858,100},{7911,12},{7912,60},{2772,40}},
maps={"Badlands"},
},[[
step
map Badlands
path follow smart; loop on; ants curved; dist 20
path	26.84,74.76	25.28,78.53	19.71,81.32	14.75,83.82	12.50,85.54
path	7.98,80.56	6.30,74.40	8.68,67.97	17.19,68.54	15.13,72.43
path	17.19,77.39	21.25,75.06	25.11,72.08
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 175 Mining to collect Mithril Ore and 230 to collect Truesilver Ore.
collect Mithril Ore##3858 |n
collect Truesilver Ore##7911 |n
collect Solid Stone##7912 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Dark Iron Ore",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={mining=230},levelreq={50,60}},
items={{11370,40},{10620,12},{12365,12},{3858,16},{7912,28}},
maps={"Burning Steppes"},
},[[
step
map Burning Steppes
path follow smart; loop on; ants curved; dist 20
path	47.24,33.58	57.79,36.68	60.09,40.49	60.24,30.28	62.87,24.54
path	64.47,23.32	65.45,24.20	64.95,33.28	71.55,39.13	79.50,25.16
path	93.16,52.72	85.24,62.18	74.63,61.27	74.12,55.90	68.15,59.00
path	64.92,57.85	62.02,54.94	47.51,59.50	43.25,60.21
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 230 Mining to collect these.
|tip These are a rare spawn.
|tip However, they can be found more consistently inside the Blackrock Depths dungeon and Molten Core raid.
collect Dark Iron Ore##11370 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Thorium Ore, Dense Stone",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={mining=245},levelreq={50,60}},
items={{10620,20},{12365,28}},
maps={"Un'Goro Crater"},
},[[
step
map Un'Goro Crater
path follow smart; loop on; ants curved; dist 20
path	66.46,78.95	64.56,79.71	61.79,84.21	59.34,84.18	57.63,86.04
path	54.50,86.69	51.13,86.82	48.27,87.30	45.98,86.58	42.89,85.00
path	40.79,83.52	37.91,83.14	36.77,80.17	33.58,79.05	30.40,79.61
path	28.89,76.98	28.97,71.52	26.00,67.67	25.93,63.53	24.59,58.51
path	23.95,53.04	24.40,48.21	23.89,44.76	24.71,41.12	26.26,36.59
path	26.62,31.21	28.29,29.47	29.59,25.66	29.89,20.92	33.32,20.67
path	36.29,20.47	38.67,16.00	41.73,15.77	43.32,14.12	46.94,13.03
path	49.79,13.83	52.84,12.88	56.31,14.04	59.61,16.58	62.25,16.02
path	64.19,19.90	65.99,21.01	68.51,20.26	71.19,20.89	71.21,23.75
path	71.75,28.19	74.76,32.46	75.06,37.15	76.32,43.15	76.67,48.32
path	77.05,53.09	76.56,57.02	75.35,61.97	74.66,68.05	72.92,70.46
path	71.39,73.80	71.00,79.21	68.32,79.90
Click ore as you follow the path around this area
|tip Track them on your minimap with "Find Minerals".
|tip You will need level 245 Mining to collect these.
collect Thorium Ore##10620 |n
collect Dense Stone##12365 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Guardian Stone",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={60,60}},
items={{12809,8}},
maps={"Un'Goro Crater"},
},[[
step
map Un'Goro Crater
path follow smart; loop on; ants curved; dist 20
path	40.24,18.78	37.48,20.20	33.48,23.57	40.40,25.92	43.96,29.92
path	44.56,36.72	43.43,40.74	44.16,43.79	48.24,41.64	51.27,39.78
path	56.65,39.87	54.16,36.20	55.85,31.39	57.79,26.10	56.20,21.10
path	56.97,14.88	53.59,13.78	51.39,17.24	48.13,13.45
Kill Stone Guardians as you follow the path around this area
|tip These are level 60-61 Elite enemies.
collect Guardian Stone##12809 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Elementium Ore",{
author="support@zygorguides.com",
},[[
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
click Orb of Command##179879 |goto 48.92,64.47
Teleport to Blackwing Lair |goto Blackwing Lair 0.00,0.00 < 1000 |noway |c
|tip You must be attuned to enter the raid.
step
Inside the Blackwing Lair Raid:
kill Blackwing Technician##13996+
collect Elementium Ore##18562 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Linen Cloth",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{2589,80}},
maps={"Westfall"},
},[[
step
Kill enemies around this area
|tip Be sure to enter the mine as well.
collect Linen Cloth##2589 |n |goto Westfall 44.55,25.01
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Wool Cloth",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{2592,80},{2589,32}},
maps={"Redridge Mountains"},
},[[
step
Follow the road up |goto Redridge Mountains 35.71,43.17 < 15 |only if walking
Continue following the road |goto 47.06,30.39 < 15 |only if walking
Follow the path up |goto 40.87,15.00 < 10 |only if walking
Kill Blackrock enemies around this area
collect Wool Cloth##2592 |n |goto 36.22,9.93
You can find more inside the cave at [33.21,6.91]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Silk Cloth",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{4306,60},{2592,20}},
maps={"Thousand Needles"},
},[[
step
Kill Galak enemies around this area
|tip You can find more inside the cave.
collect Silk Cloth##4306 |n |goto Thousand Needles 44.01,37.41
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Mageweave Cloth",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={45,60}},
items={{4338,60}},
maps={"Tanaris"},
},[[
step
Kill Dunemaul enemies around this area
collect Mageweave Cloth##4338 |n |goto Tanaris 40.50,55.50
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Runecloth",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{14047,48}},
maps={"Western Plaguelands"},
},[[
step
Kill Scarlet enemies around this area
collect Runecloth###14047 |n |goto Western Plaguelands 47.85,33.38
You can find more around [44.35,33.96]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Felcloth",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{14256,10},{4338,60}},
maps={"Felwood"},
},[[
step
Kill Jadefire enemies around this area
collect Felcloth##14256 |n |goto Felwood 37.17,67.00
You can find more around [32.71,66.66]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Mooncloth",{
author="support@zygorguides.com",
},[[
step
label "Farm_Felcloth"
Kill Jadefire enemies around this area
collect Felcloth##14256 |n |goto Felwood 37.17,67.00
Click here to transmute Felcloth into Mooncloth |confirm
|tip It only takes 2 Felcloth to make a Mooncloth, but it requires a rare Tailoring pattern and has a 4 day cooldown.
step
Open Your Tailoring Crafting Panel:
_<Create Mooncloth>_
|tip This spell has a 4 day cooldown.
collect Mooncloth##14342 |n |goto Ashenvale 60.19,72.90
Click here to farm more Felcloth |confirm |next "Farm_Felcloth"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Spider's Silk",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{3182,12},{1081,40}},
maps={"Wetlands"},
},[[
step
Enter the cave |goto Wetlands 52.79,62.90 < 20 |walk
Kill enemies around this area
|tip Inside the cave.
collect Spider's Silk##3182 |n |goto 48.51,60.67
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Thick Spider's Silk",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={58,60}},
items={{4337,8},{14047,28}},
maps={"Eastern Plaguelands"},
},[[
step
Follow the path up |goto Eastern Plaguelands 77.56,47.20 < 10 |only if walking
Kill Crypt enemies around this area
|tip You can find more inside the nearby crypt buildings.
collect Thick Spider's Silk##4337 |n |goto 83.60,42.07
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Shadow Silk",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={38,60}},
items={{10285,16},{4337,20}},
maps={"Swamp of Sorrows"},
},[[
step
kill Deathstrike Tarantula##769+
collect Shadow Silk##10285 |n |goto Swamp of Sorrows 58.74,62.39
|tip These have a low drop rate.
You can find more around [66.70,68.65]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Ironweb Spider Silk",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{14227,6}},
maps={"Silithus"},
},[[
step
kill Sand Skitterer##11738+
collect Ironweb Spider Silk##14227 |n |goto Silithus 56.25,26.22
|tip These have a low drop rate.
You can find more around: |notinsticky
[54.15,18.47]
[63.01,18.18]
[64.31,29.61]
[38.69,34.85]
[35.71,30.35]
[35.29,20.57]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Brilliant Smallfish",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=1},levelreq={5,60}},
items={{6291,100},{6289,40}},
maps={"Elwynn Forest"},
},[[
step
Fish in the open water
collect Raw Brilliant Smallfish##6291 |n |goto Elwynn Forest 33.59,63.52
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Chunk of Boar Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={1,60}},
items={{769,120}},
maps={"Elwynn Forest"},
},[[
step
kill Stonetusk Boar##113
collect Chunk of Boar Meat##769 |n |goto Elwynn Forest 41.81,87.22
You can find more around this area [32.96,84.95]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Small Egg",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{6889,100}},
maps={"Darkshore"},
},[[
step
map Darkshore
path follow smart; loop on; dist 20
path	42.54,49.69	42.84,48.54	43.76,47.68	44.83,47.93	46.07,49.39
path	46.23,50.98	45.59,52.40	44.96,53.22	44.69,54.49	43.84,53.83
path	43.01,53.12	42.10,54.15	41.70,53.04	41.80,50.80	41.19,48.45
Kill Moonkin enemies along this path
collect Small Egg##6889 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Small Spider Leg",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={5,60}},
items={{5465,100}},
maps={"Teldrassil"},
},[[
step
map Teldrassil
path follow smart; loop on; dist 20
path	61.26,54.48	59.86,54.83	58.84,56.13	57.82,55.52	56.99,57.22
path	55.71,58.31	54.17,58.29	51.90,56.43	51.01,57.05	51.06,58.72
path	51.50,61.70	51.21,65.25	51.97,66.36	53.49,68.85	53.68,66.50
path	54.51,65.63	55.15,63.62	56.43,62.23	57.59,61.30	58.39,61.25
path	59.64,62.24	61.03,61.51	62.34,60.71	62.85,58.55	62.70,56.22
path	62.20,55.24
kill Webwood Lurker##1998+
collect Small Spider Leg##5465 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Stringy Wolf Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={5,60}},
items={{2672,100}},
maps={"Dun Morogh"},
},[[
step
map Dun Morogh
path follow smart; loop on; dist 20
path	48.83,44.33	49.91,45.80	51.35,45.50	52.65,45.75	54.52,46.88
path	53.16,48.13	52.07,50.43	50.38,52.50	49.29,54.64	48.27,55.36
path	47.24,53.86	46.41,52.12	46.05,49.96	44.75,48.06	42.48,47.21
path	40.23,47.20	38.74,46.65	36.95,45.83	35.43,45.11	34.49,44.49
path	32.83,46.26	31.94,47.31	30.21,46.67	30.51,44.36	31.98,42.52
path	33.05,39.49	36.17,37.53	37.64,35.53	38.86,32.48	41.00,31.62
path	43.08,31.61	44.32,33.52	44.37,37.07	45.30,40.37
Kill Wolf enemies along this path
collect Stringy Wolf Meat##2672 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Slitherskin Mackerel",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=1},levelreq={5,60}},
items={{6303,160}},
maps={"Teldrassil"},
},[[
step
Fish in the open water
collect Raw Slitherskin Mackerel##6303 |n |goto Teldrassil 56.25,93.72
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Crag Boar Rib",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=1},levelreq={5,60}},
items={{2886,68}},
maps={"Dun Morogh"},
},[[
step
map Dun Morogh
path follow smart; loop on; dist 20
path	48.31,47.26	50.56,47.82	52.50,48.96	51.18,50.98	50.25,52.44
path	49.29,54.42	48.28,56.64	48.54,58.79	48.34,61.32	47.52,63.19
path	45.85,63.76	45.37,63.31	46.29,61.25	46.73,58.19	46.92,56.16
path	46.51,54.00	46.40,50.75	47.10,49.38	47.15,47.78
Kill Boar enemies along this path
collect Crag Boar Rib##2886 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Spider Ichor",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={13,60}},
items={{3174,48}},
maps={"Loch Modan"},
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	27.50,18.10	30.27,19.59	29.15,24.55	29.84,29.06	32.14,30.71
path	35.13,29.65	37.20,31.58	36.37,35.45	35.03,38.40	33.26,40.88
path	32.40,45.35	33.05,47.42	34.34,51.88	36.47,52.74	39.14,50.95
path	39.83,54.29	42.01,58.27	44.93,63.94	49.35,69.89	52.66,69.99
path	55.03,68.30	57.07,65.55	60.01,64.00	63.50,65.52	64.87,60.86
path	65.69,52.00	68.27,52.19	71.58,51.39	74.71,49.53	75.51,45.81
path	76.80,40.70	76.45,36.95	76.44,33.17	72.32,36.15	69.02,35.67
path	64.80,30.93	62.26,24.80	60.72,21.63	60.32,16.09	57.40,15.76
path	56.11,17.39
Kill Lurker enemies along this path
collect Spider Ichor##3174 |n
'|goto 56.11,17.39 < 20 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	56.11,17.39	57.40,15.76	60.32,16.09	60.72,21.63	62.26,24.80
path	64.80,30.93	69.02,35.67	72.32,36.15	76.44,33.17	76.45,36.95
path	76.80,40.70	75.51,45.81	74.71,49.53	71.58,51.39	68.27,52.19
path	65.69,52.00	64.87,60.86	63.50,65.52	60.01,64.00	57.07,65.55
path	55.03,68.30	52.66,69.99	49.35,69.89	44.93,63.94	42.01,58.27
path	39.83,54.29	39.14,50.95	36.47,52.74	34.34,51.88	33.05,47.42
path	32.40,45.35	33.26,40.88	35.03,38.40	36.37,35.45	37.20,31.58
path	35.13,29.65	32.14,30.71	29.84,29.06	29.15,24.55	30.27,19.59
path	27.50,18.10
Kill Lurker enemies along this path
collect Spider Ichor##3174 |n
'|goto 27.50,18.10 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Coyote Meat, Boar Intestines, Stringy Vulture Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{2673,60},{3172,40},{729,24}},
maps={"Westfall"},
},[[
step
label "Path_One"
map Westfall
path follow smart; loop off; dist 20
path	62.45,42.12	61.05,38.49	59.20,30.20	58.69,26.18	58.85,22.18
path	55.99,22.99	53.72,26.55	51.15,26.31	48.14,25.64	47.04,19.68
path	44.81,17.52	42.78,19.23	41.83,24.14	41.27,26.78	42.70,31.93
path	39.81,33.77	36.63,30.63	34.38,34.44	33.43,38.91	35.02,42.09
path	38.49,42.87
Kill enemies along this path
collect Coyote Meat##2673 |n
|tip These are only dropped by Coyote enemies.
collect Boar Intestines##3172 |n
|tip These are only dropped by Boar enemies.
collect Stringy Vulture Meat##729 |n
|tip These are only dropped by Vulture enemies.
'|goto 38.49,42.87 < 20 |noway |c
step
map Westfall
path follow smart; loop off; dist 20
path	38.49,42.87	35.02,42.09	33.43,38.91	34.38,34.44	36.63,30.63
path	39.81,33.77	42.70,31.93	41.27,26.78	41.83,24.14	42.78,19.23
path	44.81,17.52	47.04,19.68	48.14,25.64	51.15,26.31	53.72,26.55
path	55.99,22.99	58.85,22.18	58.69,26.18	59.20,30.20	61.05,38.49
path	62.45,42.12
Kill enemies along this path
collect Coyote Meat##2673 |n
|tip These are only dropped by Coyote enemies.
collect Boar Intestines##3172 |n
|tip These are only dropped by Boar enemies.
collect Stringy Vulture Meat##729 |n
|tip These are only dropped by Vulture enemies.
'|goto 62.45,42.12 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Strider Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{5469,60}},
maps={"Darkshore"},
},[[
step
map Darkshore
path follow smart; loop on; dist 20
path	41.72,45.81	42.40,44.51	43.58,42.34	44.66,42.12	46.20,41.09
path	47.32,40.10	47.90,39.85	48.42,38.69	48.61,37.31	48.50,35.08
path	48.73,33.75	49.68,32.60	50.53,30.20	50.70,28.40	50.02,26.68
path	49.23,25.39	48.00,23.46	46.94,23.20	45.63,23.60	44.92,25.24
path	44.27,27.17	43.90,29.44	43.88,31.28	43.81,33.32	42.75,34.53
path	41.64,34.45	40.24,33.90	39.53,35.70	39.27,37.38	39.07,39.41
path	39.65,40.83	40.30,42.11	39.99,44.14	38.96,46.50	39.25,47.99
path	40.57,48.26
Kill Strider enemies along this path
collect Strider Meat##5469 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Kodo Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{5467,30}},
maps={"The Barrens"},
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	46.73,67.35	46.61,69.24	46.70,71.56	46.79,75.01	46.84,79.96
path	45.00,78.85	44.87,75.78	45.31,72.93	45.54,70.61	45.76,68.23
path	45.93,66.82
Kill Kodo enemies along this path
collect Kodo Meat##5467 |n
|tip Thunderheads will not drop this item.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Murloc Eye",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{730,60}},
maps={"Westfall"},
},[[
step
Kill Murloc enemies around this area
|tip They spawn all along the coast, so you can move down to get more.
collect Murloc Eye##730 |n |goto Westfall 55.73,9.49
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Bear Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{3173,60}},
maps={"Darkshore"},
},[[
step
map Darkshore
path follow smart; loop on; ants curved; dist 20
path	45.52,35.10	46.86,35.15	47.88,33.99	48.82,34.11	49.47,33.15
path	49.81,31.71	49.00,30.97	48.64,29.50	49.29,27.40	48.64,27.07
path	48.40,25.88	48.18,24.49	47.62,23.22	46.59,22.69	45.54,23.42
path	44.37,23.40	44.27,24.98	43.83,26.43	44.32,27.91	43.94,29.27
path	44.78,30.11	45.40,31.46	44.78,32.44	43.97,32.76	42.43,32.68
path	41.39,33.60	41.66,35.17	42.07,37.43	42.42,39.82	43.17,41.92
path	44.41,42.90	45.25,43.21	45.48,41.84
Kill Bear enemies along this path
collect Bear Meat##3173 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Goretusk Snout, Goretusk Liver",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{731,48},{723,52}},
maps={"Westfall"},
},[[
step
map Westfall
path follow smart; loop on; dist 20
path	54.77,43.68	52.06,43.69	49.12,42.27	45.09,41.88	43.96,44.88
path	41.67,44.84	39.02,39.33	39.16,34.42	35.06,35.23	33.65,38.77
path	34.88,42.29	35.10,44.27	37.31,45.80	39.99,48.75	42.97,53.04
path	41.95,57.70	39.61,60.26	40.13,64.84	42.23,64.99	45.21,63.19
path	46.83,61.93	47.60,58.82	49.94,58.52	51.66,61.20	54.37,59.63
path	56.14,55.00	55.49,50.62	55.02,47.55
Kill Goretusk enemies along this path
collect Goretusk Snout##731 |n
collect Goretusk Liver##723 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Crawler Meat, Crawler Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{2674,48},{2675,40}},
maps={"Westfall"},
},[[
step
map Westfall
path follow smart; loop off; dist 20
path	51.32,9.67	49.06,10.01	44.72,8.70	41.78,10.34	38.85,13.51
path	36.20,18.29	33.45,22.08	31.88,24.30
Kill Crawler enemies around this area
|tip You can find more further down the coast.
collect Crawler Meat##2674 |n
collect Crawler Claw##2675 |n
'|goto 31.88,24.30 < 20 |noway |c
step
map Westfall
path follow smart; loop off; dist 20
path	31.88,24.30	33.45,22.08	36.20,18.29	38.85,13.51	41.78,10.34
path	44.72,8.70	49.06,10.01	51.32,9.67
Kill Crawler enemies around this area
|tip You can find more further down the coast.
collect Crawler Meat##2674 |n
collect Crawler Claw##2675 |n
'|goto 51.32,9.67 < 20 |noway |c
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Clam Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{5503,52}},
maps={"Westfall"},
},[[
step
Kill Murloc enemies around this area
|tip They are found all along the coastline.
collect Small Barnacled Clam##5523 |n
use the Small Barnacled Clam##5523
collect Clam Meat##5503 |n |goto Westfall 37.26,15.67
|tip They are inside of the Small Barnacled Clams.
You can find more around here [31.16,26.10]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Boar Ribs",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{2677,30}},
maps={"Loch Modan"},
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	27.50,18.10	30.27,19.59	29.15,24.55	29.84,29.06	32.14,30.71
path	35.13,29.65	37.20,31.58	36.37,35.45	35.03,38.40	33.26,40.88
path	32.40,45.35	33.05,47.42	34.34,51.88	36.47,52.74	39.14,50.95
path	39.83,54.29	42.01,58.27	44.93,63.94	49.35,69.89	52.66,69.99
path	55.03,68.30	57.07,65.55	60.01,64.00	63.50,65.52	64.87,60.86
path	65.69,52.00	68.27,52.19	71.58,51.39	74.71,49.53	75.51,45.81
path	76.80,40.70	76.45,36.95	76.44,33.17	72.32,36.15	69.02,35.67
path	64.80,30.93	62.26,24.80	60.72,21.63	60.32,16.09	57.40,15.76
path	56.11,17.39
Kill Boar enemies along this path
collect Boar Ribs##2677 |n
'|goto 56.11,17.39 < 20 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	56.11,17.39	57.40,15.76	60.32,16.09	60.72,21.63	62.26,24.80
path	64.80,30.93	69.02,35.67	72.32,36.15	76.44,33.17	76.45,36.95
path	76.80,40.70	75.51,45.81	74.71,49.53	71.58,51.39	68.27,52.19
path	65.69,52.00	64.87,60.86	63.50,65.52	60.01,64.00	57.07,65.55
path	55.03,68.30	52.66,69.99	49.35,69.89	44.93,63.94	42.01,58.27
path	39.83,54.29	39.14,50.95	36.47,52.74	34.34,51.88	33.05,47.42
path	32.40,45.35	33.26,40.88	35.03,38.40	36.37,35.45	37.20,31.58
path	35.13,29.65	32.14,30.71	29.84,29.06	29.15,24.55	30.27,19.59
path	27.50,18.10
Kill Boar enemies along this path
collect Boar Ribs##2677 |n
'|goto 27.50,18.10 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Crocolisk Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={12,60}},
items={{2924,44}},
maps={"Loch Modan"},
},[[
step
label "Path_One"
map Loch Modan
path follow smart; loop off; dist 20
path	59.07,58.33	61.96,54.52	62.60,51.20	62.93,48.10	61.85,44.72
path	59.99,41.23	58.93,39.15	56.80,39.21	54.29,41.28	52.90,36.82
path	56.38,35.56	58.29,34.14	57.78,30.70	58.28,23.79	56.87,21.44
Kill Crocolisk enemies along this path
collect Crocolisk Meat##2924 |n
'|goto 56.87,21.44 < 20 |noway |c
step
map Loch Modan
path follow smart; loop off; dist 20
path	56.87,21.44	58.28,23.79	57.78,30.70	58.29,34.14	56.38,35.56
path	52.90,36.82	54.29,41.28	56.80,39.21	58.93,39.15	59.99,41.23
path	61.85,44.72	62.93,48.10	62.60,51.20	61.96,54.52	59.07,58.33
Kill Crocolisk enemies along this path
collect Crocolisk Meat##2924 |n
'|goto 59.07,58.33 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Rainbow Fin Albacore",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=1},levelreq={5,60}},
items={{6361,80}},
maps={"Wetlands"},
},[[
step
Fish in the Open Water
collect Raw Rainbow Fin Albacore##6361 |n |goto Wetlands 9.32,61.63
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Longjaw Mud Snapper",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=1},levelreq={5,60}},
items={{6289,100}},
maps={"Stormwind City"},
},[[
step
Fish in the Open Water
collect Raw Longjaw Mud Snapper##6289 |n |goto Stormwind City 45.37,57.54
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Tough Condor Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={18,60}},
items={{1080,12}},
maps={"Redridge Mountains"},
},[[
step
label "Path_One"
map Redridge Mountains
path follow smart; loop off; dist 20
path	40.90,39.07	42.13,33.74	45.43,30.76	48.37,31.50	49.98,33.27
path	51.31,34.71	54.57,38.75	56.34,40.65	58.08,41.06	61.81,39.87
path	65.27,42.43
Kill Condor enemies along this path
collect Tough Condor Meat##1080 |n
'|goto 65.27,42.43 < 20 |noway |c
step
map Redridge Mountains
path follow smart; loop off; dist 20
path	62.49,39.72	59.22,40.52	56.35,41.43	57.19,45.31	55.36,45.91
path	52.71,42.81	50.52,41.90	49.25,41.66	46.85,37.78	44.32,37.81
path	42.56,37.84	39.61,39.63
Kill Condor enemies along this path
collect Tough Condor Meat##1080 |n
'|goto 39.61,39.63 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Soft Frenzy Flesh",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{5468,60}},
maps={"Darkshore"},
},[[
step
map Darkshore
path follow smart; loop on; dist 20
path	34.24,60.68	31.91,61.15	33.77,66.17	33.07,67.99	32.05,71.24
path	31.26,73.36	32.40,75.21	32.04,77.87	34.60,77.45	34.68,74.58
path	34.79,72.62	35.34,70.00	35.82,66.96	35.50,65.25	35.59,62.93
path	35.54,60.26
kill Coastal Frenzy##2174+
|tip They are underwater along this path.
collect Soft Frenzy Flesh##5468 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Loch Frenzy",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{6317,60}},
maps={"Loch Modan"},
},[[
step
map Loch Modan
path follow smart; loop on; dist 20
path	44.56,30.72	44.43,24.86	44.40,19.25	47.08,17.29	50.60,16.64
path	52.93,18.26	55.24,22.03	56.79,25.41	56.33,29.61	52.70,31.04
path	49.85,32.36	46.69,32.19
kill Loch Frenzy##1193+
|tip They are underwater along this path.
collect Raw Loch Frenzy##6317 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Murloc Fin",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={18,60}},
items={{1468,64},{730,60},{5503,64}},
maps={"Ashenvale"},
},[[
step
map Ashenvale
path follow smart; loop on; ants curved; dist 20
path	20.90,40.21	21.33,41.92	21.06,43.30	20.66,44.48	19.75,43.65
path	19.08,42.84	18.81,41.34	18.96,40.20	19.58,41.07
Kill Saltspittle enemies around this area
collect Murloc Fin##1468 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lean Wolf Flank",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={17,60}},
items={{1015,16}},
maps={"Duskwood"},
},[[
step
label "Path_One"
map Duskwood
path follow smart; loop off; dist 20
path	63.16,28.80	64.53,25.32	66.25,22.72	68.11,20.39	65.79,19.10
path	63.93,18.00	61.85,17.35	61.24,19.93	59.17,22.31	57.44,22.15
path	55.99,19.56	54.52,17.35	52.93,14.73	51.60,17.10	50.35,19.66
path	49.58,17.59	48.56,16.46	46.52,16.89	44.73,18.76	43.31,20.29
path	41.58,18.79	39.78,19.76	37.72,19.38	36.39,21.44	37.40,24.54
path	35.14,24.60	32.82,24.47	31.96,27.24	29.31,27.36	27.36,26.54
path	25.34,27.61	22.46,25.92	20.45,25.75	18.66,23.98	16.18,27.47
path	14.08,27.45	12.25,30.98	10.25,32.63
Kill Wolf enemies around this area
collect Lean Wolf Flank##1015 |n
'|goto 10.25,32.63 < 20 |noway |c
step
map Duskwood
path follow smart; loop off; dist 20
path	10.25,32.63	12.25,30.98	14.08,27.45	16.18,27.47	18.66,23.98
path	20.45,25.75	22.46,25.92	25.34,27.61	27.36,26.54	29.31,27.36
path	31.96,27.24	32.82,24.47	35.14,24.60	37.40,24.54	36.39,21.44
path	37.72,19.38	39.78,19.76	41.58,18.79	43.31,20.29	44.73,18.76
path	46.52,16.89	48.56,16.46	49.58,17.59	50.35,19.66	51.60,17.10
path	52.93,14.73	54.52,17.35	55.99,19.56	59.17,22.31	61.24,19.93
path	61.85,17.35	63.93,18.00	65.79,19.10	68.11,20.39	66.25,22.72
path	64.53,25.32	63.16,28.80
Kill Wolf enemies around this area
collect Lean Wolf Flank##1015 |n
'|goto 63.16,28.80 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Sagefish",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=100},levelreq={30,60}},
items={{21071,120}},
maps={"Hillsbrad Foothills"},
},[[
step
Fish from Sagefish Schools in the water around this area
collect Raw Sagefish##21071 |n |goto Hillsbrad Foothills 62.51,43.06
|tip Follow the river north for more schools.
|tip You will need level 100 Fishing to catch these.
You can find more around [69.87,13.66]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Big Bear Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{3730,60}},
maps={"Hillsbrad Foothills"},
},[[
step
map Hillsbrad Foothills
path follow smart; loop on; dist 20
path	38.33,38.22	38.83,41.84	40.63,44.03	42.02,47.77	43.74,49.21
path	44.53,52.30	48.19,47.24	53.47,48.86	54.78,44.77	56.02,39.61
path	53.80,34.79	52.80,31.91	50.32,32.11	48.17,34.26	45.68,36.53
path	43.61,37.51	41.05,36.09	37.81,33.55
Kill Bear enemies around this area
collect Big Bear Meat##3730 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raptor Egg",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{3685,40}},
maps={"Wetlands"},
},[[
step
map Wetlands
path follow smart; loop on; dist 20
path	20.63,48.84	21.22,52.36	22.52,55.60	23.52,53.14	24.47,52.25
path	24.33,49.93	26.28,48.80	26.45,47.06	27.37,45.66	23.64,46.15
path	22.34,50.55
Kill Raptor enemies around this area
collect Raptor Egg##3685 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Thunder Lizard Tail",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{5470,60}},
maps={"The Barrens"},
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	46.58,56.30	48.58,57.05	48.69,58.20	48.80,59.11	48.24,60.56
path	48.43,62.12	48.27,63.65	47.64,65.24	46.80,67.81	46.67,68.85
path	46.58,71.45	47.01,73.09	46.67,74.29	47.26,75.11	47.86,75.81
path	48.51,76.74	49.30,77.70	48.91,78.77	47.66,80.13	46.53,79.48
path	44.91,79.17	44.65,78.42	44.58,76.68	44.47,75.54	44.75,74.17
path	45.56,72.50	45.56,70.73	45.79,69.01	46.03,66.53	45.23,64.79
path	45.30,63.46	46.25,61.69	46.94,60.01	47.00,58.41
Kill Thunderhead enemies around this area
collect Thunder Lizard Tail##5470 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Tangy Clam Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{5504,40}},
maps={"Wetlands"},
},[[
step
map Wetlands
path follow smart; loop on; dist 20
path	15.21,40.13	17.36,39.06	19.36,38.16	22.88,37.14	24.91,36.76
path	24.41,33.77	23.10,33.59	21.34,34.34	19.64,31.98	18.24,31.36
path	16.84,29.42	15.14,30.74	14.96,33.33	14.32,35.71	13.91,38.13
path	14.03,40.90
Kill Bluegill enemies around this area
collect Thick-shelled Clam##5524 |n
use the Thick-shelled Clam##5524
collect Tangy Clam Meat##5504 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Tender Crocolisk Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{3667,60}},
maps={"Dustwallow Marsh"},
},[[
step
label "Path_One"
map Dustwallow Marsh
path follow smart; loop off; dist 20
path	42.01,28.23	41.27,30.48	40.81,32.17	39.51,33.86	38.27,35.06
path	39.30,36.33	40.52,36.90	41.08,38.12	42.23,39.13	42.29,41.27
path	40.44,41.83	39.76,43.93	39.29,45.36	38.51,45.82	37.54,46.50
path	36.53,47.94	35.50,49.39	36.60,52.40	38.28,53.98	40.81,54.72
path	41.62,55.99	40.68,58.48	40.53,61.02
Kill Drywallow enemies along this path
collect Tender Crocolisk Meat##3667 |n
'|goto 40.53,61.02 < 20 |noway |c
step
map Dustwallow Marsh
path follow smart; loop off; dist 20
path	40.53,61.02	40.68,58.48	41.62,55.99	40.81,54.72	38.28,53.98
path	36.60,52.40	35.50,49.39	36.53,47.94	37.54,46.50	38.51,45.82
path	39.29,45.36	39.76,43.93	40.44,41.83	42.29,41.27	42.23,39.13
path	41.08,38.12	40.52,36.90	39.30,36.33	38.27,35.06	39.51,33.86
path	40.81,32.17	41.27,30.48	42.01,28.23
Kill Drywallow enemies along this path
collect Tender Crocolisk Meat##3667 |n
'|goto 42.01,28.23 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lion Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={25,60}},
items={{3731,28}},
maps={"Hillsbrad Foothills"},
},[[
step
map Hillsbrad Foothills
path follow smart; loop on; ants curved; dist 20
path	53.45,35.50	54.82,31.40	50.85,30.94	48.73,31.20	47.14,34.19
path	44.82,36.37	42.94,35.61	40.84,34.75	37.39,30.82	38.60,37.24
path	39.02,42.97	41.37,42.61	42.89,40.98	44.43,45.21	47.44,44.25
path	50.74,47.10	53.15,47.46	55.37,44.48	54.69,42.88	56.10,41.00
path	56.82,37.61
kill Starving Mountain Lion##2384+
collect Lion Meat##3731 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Stag Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={20,60}},
items={{5471,40}},
maps={"Stonetalon Mountains"},
},[[
step
label "Path_One"
map Stonetalon Mountains
path follow smart; loop off; dist 20
path	50.21,36.84	49.75,34.63	48.15,33.61	46.91,32.12	46.84,28.49
path	46.38,25.94	45.77,24.36	44.95,22.28	44.66,19.95	44.13,17.21
path	43.26,16.08	41.50,15.94	40.17,15.24	39.42,12.31	39.94,10.54
path	40.29,8.62	40.73,6.34	39.49,6.04
Kill Courser enemies along this path
collect Stag Meat##5471 |n
'|goto 39.49,6.04 < 30 |noway |c
step
map Stonetalon Mountains
path follow smart; loop off; dist 20
path	39.49,6.04	40.73,6.34	40.29,8.62	39.94,10.54	39.42,12.31
path	40.17,15.24	41.50,15.94	43.26,16.08	44.13,17.21	44.66,19.95
path	44.95,22.28	45.77,24.36	46.38,25.94	46.84,28.49	46.91,32.12
path	48.15,33.61	49.75,34.63	50.21,36.84
Kill Courser enemies along this path
collect Stag Meat##5471 |n
'|goto 50.21,36.84 < 30 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Bristle Whisker Catfish",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=1},levelreq={5,60}},
items={{6308,48}},
maps={"Stormwind City"},
},[[
step
Fish in the Open Water
collect Raw Bristle Whisker Catfish##6308 |n |goto Stormwind City 45.37,57.54
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Gooey Spider Leg",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={17,60}},
items={{2251,80}},
maps={"Duskwood"},
},[[
step
label "Path_One"
map Duskwood
path follow smart; loop off; dist 20
path	75.39,23.25	75.70,20.27	72.81,20.02	68.45,21.26	66.04,20.18
path	64.38,23.56	62.25,25.40	58.25,19.25	55.59,20.51	53.13,20.33
path	50.65,16.19	48.36,17.34	46.63,16.65
Kill Spider enemies along this path
collect Gooey Spider Leg##2251 |n
'|goto 46.63,16.65 < 20 |noway |c
step
map Duskwood
path follow smart; loop off; dist 20
path	46.63,16.65	48.36,17.34	50.65,16.19	53.13,20.33	55.59,20.51
path	58.25,19.25	62.25,25.40	64.38,23.56	66.04,20.18	68.45,21.26
path	72.81,20.02	75.70,20.27	75.39,23.25
Kill Spider enemies along this path
collect Gooey Spider Leg##2251 |n
'|goto 75.39,23.25 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Mystery Meat, Buzzard Wing",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{12037,28},{3404,32}},
maps={"Desolace"},
},[[
step
map Desolace
path follow smart; loop on; ants curved; dist 20
path	51.29,44.72	53.48,47.10	55.33,46.17	57.48,48.07	58.96,47.63
path	60.75,46.43	62.24,44.62	63.57,45.94	63.27,49.13	61.69,55.00
path	61.88,58.44	62.94,65.32	61.88,68.70	62.74,70.12	63.61,72.54
path	61.39,75.80	59.53,76.20	60.04,79.61	59.47,82.26	56.81,86.32
path	54.85,86.07	52.40,86.59	50.42,87.94	48.11,87.57	44.00,86.02
path	41.14,82.82	42.54,77.20	43.81,73.09	42.57,70.49	41.77,66.08
path	42.23,61.68	42.51,57.62	43.63,55.03	43.45,50.95	41.83,49.60
path	41.89,45.46	45.18,40.98	45.64,38.42	48.07,39.13	50.82,41.52
Kill enemies around this area
collect Mystery Meat##12037 |n
collect Buzzard Wing##3404 |n
|tip These are only dropped by Dread enemies.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Red Wolf Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={40,60}},
items={{12203,40}},
maps={"The Hinterlands"},
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	16.99,49.54	14.76,51.94	16.34,54.97	19.20,54.81	21.00,55.69
path	22.67,53.75	24.13,52.68	22.29,51.46	20.61,50.68	19.10,49.49
kill Mangy Silvermane##2923+
collect Red Wolf Meat##12203 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Turtle Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={30,60}},
items={{3712,40}},
maps={"Hillsbrad Foothills"},
},[[
step
label "Path_One"
map Hillsbrad Foothills
path follow smart; loop off; dist 20
path	55.45,57.43	56.82,50.74	58.10,47.76	59.58,47.03	61.27,45.60
path	61.69,42.44	63.66,39.71	66.35,38.58	67.91,34.65	68.11,31.05
path	68.53,27.79	68.76,23.80	68.71,17.57	69.11,12.97	71.53,8.15
map Alterac Mountains
path	73.57,66.04	77.21,62.35	79.49,58.40	81.26,54.60	84.17,52.70
path	87.28,49.70	90.76,47.21
Kill Snapjaw enemies along this path
collect Turtle Meat##3712 |n
'|goto 90.76,47.21 < 20 |noway |c
step
map Alterac Mountains
path follow smart; loop off; dist 20
path	90.76,47.21	87.28,49.70	84.17,52.70	81.26,54.60	79.49,58.40
path	77.21,62.35	73.57,66.04
map Hillsbrad Foothills
path	71.53,8.15	69.11,12.97	68.71,17.57	68.76,23.80	68.53,27.79
path	68.11,31.05	67.91,34.65	66.35,38.58	63.66,39.71	61.69,42.44
path	61.27,45.60	59.58,47.03	58.10,47.76	56.82,50.74	55.45,57.43
Kill Snapjaw enemies along this path
collect Turtle Meat##3712 |n
'|goto 55.45,57.43 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Tiger Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={30,60}},
items={{12202,40}},
maps={"Stranglethorn Vale"},
},[[
step
map Stranglethorn Vale
path follow smart; loop on; ants curved; dist 20
path	37.17,11.59	36.03,11.59	35.04,11.61	33.93,9.90	32.59,9.49
path	31.34,8.40	31.71,9.95	32.62,10.51	33.06,11.72	33.88,12.60
path	34.58,13.61	35.43,12.75	36.60,13.36	37.41,14.77	38.14,14.47
path	38.22,13.67	38.39,12.20	39.14,10.33	39.08,9.00	37.71,9.37
Kill Tiger enemies around this area
collect Tiger Meat##12202 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raptor Flesh",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={30,60}},
items={{12184,40}},
maps={"Stranglethorn Vale"},
},[[
step
label "Path_One"
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	30.64,25.20	30.40,23.48	31.45,23.06	31.36,21.37	30.71,18.47
path	29.83,16.33	28.80,16.28	27.47,16.45	26.82,17.50	26.75,15.82
path	25.58,15.93	23.70,15.50
Kill Raptor enemies around this area
collect Raptor Flesh##12184 |n
'|goto 23.70,15.50 < 20 |noway |c
step
map Stranglethorn Vale
path follow smart; loop off; dist 20
path	23.70,15.50	25.58,15.93	26.75,15.82	26.82,17.50	27.47,16.45
path	28.80,16.28	29.83,16.33	30.71,18.47	31.36,21.37	31.45,23.06
path	30.40,23.48	30.64,25.20
Kill Raptor enemies around this area
collect Raptor Flesh##12184 |n
'|goto 30.64,25.20 < 20 |noway |c |next "Path_One"
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Mithril Head Trout",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=130},levelreq={30,60}},
items={{8365,60}},
maps={"Dustwallow Marsh"},
},[[
step
Fish in the Open Water
collect Raw Mithril Head Trout##8365 |n |goto Dustwallow Marsh 59.95,34.54
|tip You will need level 130 Fishing to catch these.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Rockscale Cod",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=130},levelreq={20,60}},
items={{6362,100}},
maps={"Stranglethorn Vale"},
},[[
step
Fish in the Open Water
collect Raw Rockscale Cod##6362 |n |goto Stranglethorn Vale 26.22,73.57
|tip You will need level 130 Fishing to catch these.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Giant Clam Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{4655,16},{4611,28}},
maps={"Stranglethorn Vale"},
},[[
step
click Giant Clam##2744+
|tip They look like large shells underwater around this area.
|tip Elixirs of Water Breathing are very helpful while farming these.
collect Giant Clam Meat##4655 |n |goto Stranglethorn Vale 26.75,26.88
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raw Sunscale Salmon",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={fishing=205},levelreq={40,60}},
items={{13760,24}},
maps={"Feralas"},
},[[
step
Fish in the Open Water
collect Raw Sunscale Salmon##13760 |n |goto Feralas 62.39,52.49
|tip You will need level 205 Fishing to catch these.
|tip This fish can only be caught during the day; they cannot be caught between midnight and 6 AM server time.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Essence of Water",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{7080,6},{7070,4}},
maps={"Eastern Plaguelands"},
},[[
step
Kill enemies around this area
|tip Only Plague Ravagers and Blighted Surges will drop this item.
collect Essence of Water##7080 |n |goto Eastern Plaguelands 61.65,81.13
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Living Essence",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{12803,6}},
maps={"Un'Goro Crater"},
},[[
step
Kill Tar enemies around this area
collect Living Essence##12803 |n |goto Un'Goro Crater 46.46,17.23
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Essence of Fire",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{7078,6}},
maps={"Un'Goro Crater"},
},[[
step
Follow the path up |goto Un'Goro Crater 52.06,42.40 < 10 |only if walking
Kill enemies around this area
collect Essence of Fire##7078 |n |goto 49.32,48.31
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Essence of Air, Breath of Wind, Elemental Air",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{7082,6},{7081,4},{7069,4}},
maps={"Silithus"},
},[[
step
kill Dust Stormer##11744+
collect Essence of Air##7082 |n |goto Silithus 31.69,18.15
collect Breath of Wind##7081 |n |goto 31.69,18.15
collect Elemental Air##7069 |n |goto 31.69,18.15
|tip These have a low drop rate.
You can find more around [21.34,29.92]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Essence of Earth, Core of Earth",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{7076,6},{7075,6},{7912,40},{8150,24}},
maps={"Silithus"},
},[[
step
kill Desert Rumbler##11746+
collect Essence of Earth##7076 |n |goto Silithus 22.37,11.12
collect Core of Earth##7075 |n |goto Silithus 22.37,11.12
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Essence of Undeath",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{12808,4}},
maps={"Western Plaguelands"},
},[[
step
Follow the path |goto Western Plaguelands 56.61,78.55 < 10 |only if walking
Continue following the path |goto 68.58,80.14 < 10 |only if walking
Run up the stairs |goto 69.94,74.00 < 7 |only if walking
Enter the building |goto Eastern Kingdoms 52.79,26.43 < 7 |walk
click Scholomance Door |goto 52.75,26.41 < 5 |walk
Enter the Scholomance dungeon |goto 52.70,26.38 < 5 |c
step
Kill enemies throughout the dungeon
collect Essence of Undeath##12808 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Heart of the Wild",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{10286,4}},
maps={"Western Plaguelands"},
},[[
step
Enter the cave |goto Western Plaguelands 64.78,38.69 < 5 |walk
Kill enemies around this area
|tip Inside the cave.
|tip Rotting Behemoths and Decaying Horrors can drop Heart of the Wild.
|tip The enemies share spawn points, so killing the oozes will spawn more elemental enemies.
collect Heart of the Wild##10286 |n |goto 61.43,36.20
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Ichor of Undeath",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{7972,20}},
maps={"Winterspring"},
},[[
step
Kill Highborne enemies around this area
collect Ichor of Undeath##7972 |n |goto Winterspring 52.59,40.68
|tip These have a low drop rate.
You can find more around: |notinsticky
[53.62,42.09]
[56.02,44.24]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Heart of Fire",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{7077,6},{7067,8}},
maps={"Felwood"},
},[[
step
Kill Entropic enemies around this area
collect Heart of Fire##7077 |n |goto Felwood 40.92,40.34
|tip These have a low drop rate.
You can find more around [42.51,37.87]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Globe of Water",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{7079,6},{7080,4}},
maps={"Felwood"},
},[[
step
kill Toxic Horror##7132+
collect Globe of Water##7079 |n |goto Felwood 49.48,23.46
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Elemental Fire",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{7068,8}},
maps={"Arathi Highlands"},
},[[
step
kill Burning Exile##2760+
collect Elemental Fire##7068 |n |goto Arathi Highlands 24.80,29.95
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Elemental Earth, Deeprock Salt, Solid Stone",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={40,60}},
items={{7067,8},{8150,40},{7912,40}},
maps={"Badlands"},
},[[
step
Follow the path up |goto Badlands 46.37,77.20
kill Rock Elemental##92+
collect Elemental Earth##7067 |n |goto 43.30,84.24
collect Deeprock Salt##8150 |n |goto 43.30,84.24
collect Solid Stone##7912 |n |goto 43.30,84.24
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Elemental Water",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{7070,8}},
maps={"Arathi Highlands"},
},[[
step
kill Cresting Exile##2761+
collect Elemental Water##7070 |n |goto Arathi Highlands 66.70,29.91
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Elemental Air",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{7069,16}},
maps={"Arathi Highlands"},
},[[
step
kill Thundering Exile##2762+
collect Elemental Air##7069 |n |goto Arathi Highlands 52.03,50.77
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Strange Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 5-20 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Small Glimmering Shards instead of Strange Dust.
collect Strange Dust##10940 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lesser Magic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 3-12 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Strange Dust instead of Lesser Magic Essence.
collect Lesser Magic Essence##10938 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Greater Magic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 9-21 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Strange Dust instead of Greater Magic Essence.
|tip You can turn 3 Lesser Magic Essences into a Greater Magic Essence.
collect Greater Magic Essence##10939 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lesser Eternal Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 40-50 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Dream Dust instead of Lesser Eternal Essence.
collect Lesser Eternal Essence##16202 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Greater Eternal Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-60 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Illusion Dust instead of Greater Eternal Essence.
|tip You can turn 3 Lesser Eternal Essences into a Greater Eternal Essence.
collect Greater Eternal Essence##16203 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Small Brilliant Shard",{
author="support@zygorguides.com",
},[[
step
Disenchant level 38-50 blue and green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Dream Dust instead of Small Brilliant Shards.
collect Small Brilliant Shard##14343 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Large Brilliant Shard",{
author="support@zygorguides.com",
},[[
step
Disenchant level 50-58 blue weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may very rarely get Nexus Crystals instead of Large Brilliant Shards.
collect Large Brilliant Shard##14344 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Illusion Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-60 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
|tip You may sometimes get Greater Eternal Essence instead of Illusion Dust.
collect Illusion Dust##16204 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lesser Astral Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 20-25 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Astral Essence##10998 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Greater Astral Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 20-30 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Astral Essence##11082 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Soul Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 25-35 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Soul Dust##11083 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lesser Mystic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 30-35 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Mystic Essence##11134 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Greater Mystic Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 35-40 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Mystic Essence##11135 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Vision Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 35-45 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Vision Dust##11137 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lesser Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 40-45 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Nether Essence##11174 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Greater Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-50 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Nether Essence##11175 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Dream Dust",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-55 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Dream Dust##11176 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Greater Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 45-50 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Greater Nether Essence##11175 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Lesser Nether Essence",{
author="support@zygorguides.com",
},[[
step
Disenchant level 40-45 green weapons and armor
|tip You can disenchant old gear or buy some off the Auction House.
collect Lesser Nether Essence##11174 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Green Whelp Scale, Heavy Leather, Medium Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=170},levelreq={35,60}},
items={{7392,28},{4234,44},{2319,36}},
maps={"Swamp of Sorrows"},
},[[
step
Kill Whelp enemies around this area
|tip Skin their corpses.
|tip You will need level 170 Skinning to collect these.
collect Green Whelp Scale##7392 |n |goto Swamp of Sorrows 13.29,64.20
|tip These have a low drop rate.
collect Heavy Leather##4234 |n |goto Swamp of Sorrows 13.29,64.20
collect Medium Leather##2319 |n |goto Swamp of Sorrows 13.29,64.20
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Black Whelp Scale, Light Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=70},levelreq={15,60}},
items={{7286,66},{2318,120}},
maps={"Redridge Mountains"},
},[[
step
kill Black Dragon Whelp##441+
|tip Skin their corpses.
|tip You will need level 70 Skinning to collect these.
collect Black Whelp Scale##7286 |n |goto Redridge Mountains 34.85,69.67
|tip These have a low drop rate.
collect Light Leather##2318 |n |goto Redridge Mountains 34.85,69.67
You can find more around: |notinsticky
[29.64,74.26]
[46.74,77.01]
[57.29,75.08]
[66.62,76.17]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Light Leather, Ruined Leather Scraps",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=1},levelreq={5,60}},
items={{2318,60},{2934,80}},
maps={"Elwynn Forest"},
},[[
step
kill Stonetusk Boar##113+
|tip Skin their corpses.
collect Light Leather##2318 |n |goto Elwynn Forest 41.58,86.96
collect Ruined Leather Scraps##2934 |n |goto Elwynn Forest 41.58,86.96
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Thin Kodo Leather",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={10,60}},
items={{5082,20}},
maps={"The Barrens"},
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	48.32,63.77	46.77,67.86	47.33,72.51	48.23,76.23	48.03,80.88
path	44.76,80.45	44.63,73.81	45.67,69.12	45.20,64.63	46.23,61.11
Kill Kodo enemies as you follow the path around this area
|tip They walk in packs around this area.
|tip Thunderheads and Stormhides won't drop this item.
collect Thin Kodo Leather##5082 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Light Hide, Light Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=100},levelreq={20,60}},
items={{783,8},{2318,52},{2319,36}},
maps={"The Barrens"},
},[[
step
map The Barrens
path follow smart; loop on; ants curved; dist 20
path	48.32,63.77	46.77,67.86	47.33,72.51	48.23,76.23	48.03,80.88
path	44.76,80.45	44.63,73.81	45.67,69.12	45.20,64.63	46.23,61.11
Kill enemies as you follow the path around this area
|tip Only beast enemies will be skinnable.
|tip Skin their corpses.
|tip You will need level 100 Skinning to collect these.
collect Light Hide##783 |n
|tip These have a low drop rate.
collect Light Leather##2318 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Slimy Murloc Scale",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={16,60}},
items={{5784,32}},
maps={"Silverpine Forest"},
},[[
step
Kill Vile Fin enemies around this area
collect Slimy Murloc Scale##5784 |n |goto Silverpine Forest 78.30,30.76
You can find more around: |notinsticky
[80.06,28.45]
[73.54,17.09]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Medium Leather, Heavy Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=155},levelreq={30,60}},
items={{2319,80},{4234,48}},
maps={"Hillsbrad Foothills"},
},[[
step
Kill Yeti enemies around this area
|tip Skin their corpses.
|tip You can find more inside the cave.
|tip You will need level 155 Skinning to collect these.
collect Medium Leather##2319 |n |goto Hillsbrad Foothills 46.12,31.76
collect Heavy Leather##4234 |n |goto Hillsbrad Foothills 46.12,31.76
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Medium Hide, Medium Leather, Light Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=115},levelreq={20,60}},
items={{4232,8},{2319,48},{2318,40}},
maps={"Stonetalon Mountains"},
},[[
step
kill Blackened Basilisk##4044+
|tip Skin their corpses.
|tip You will need level 115 Skinning to collect these.
collect Medium Hide##4232 |n |goto Stonetalon Mountains 44.88,41.82
|tip These have a low drop rate.
collect Medium Leather##2319 |n |goto Stonetalon Mountains 44.88,41.82
collect Light Leather##2318 |n |goto Stonetalon Mountains 44.88,41.82
You can find more around [36.49,48.50]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Heavy Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=185},levelreq={35,60}},
items={{4234,100}},
maps={"Dustwallow Marsh"},
},[[
step
Kill enemies around this area
|tip Only beast enemies will be skinnable.
|tip Skin their corpses.
|tip You will need level 185 Skinning to collect these.
collect Heavy Leather##4234 |n |goto Dustwallow Marsh 40.73,58.37
You can find more around: |notinsticky
[43.35,50.06]
[40.42,41.57]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Raptor Hide",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{4461,40}},
maps={"Arathi Highlands"},
},[[
step
Kill Highland enemies around this area
collect Raptor Hide##4461 |n |goto Arathi Highlands 52.39,67.61
You can find more around [47.28,78.85]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Heavy Hide, Heavy Leather, Thick Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=205},levelreq={40,60}},
items={{4235,8},{4234,60},{4304,40}},
maps={"The Hinterlands"},
},[[
step
Kill enemies around this area
|tip Skin their corpses.
|tip You will need level 205 Skinning to collect these.
collect Heavy Hide##4235 |n |goto The Hinterlands 16.19,50.97
|tip These have a low drop rate.
collect Heavy Leather##4234 |n |goto The Hinterlands 16.19,50.97
collect Thick Leather##4304 |n |goto The Hinterlands 16.19,50.97
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Turtle Scale, Heavy Leather, Thick Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=210},levelreq={40,60}},
items={{8167,66},{4234,60},{4304,56}},
maps={"Tanaris"},
},[[
step
kill Steeljaw Snapper##14123+
|tip Skin their corpses.
|tip You will need level 210 Skinning to collect these.
collect Turtle Scale##8167 |n |goto Tanaris 67.22,25.77
collect Heavy Leather##4234 |n |goto Tanaris 67.22,25.77
collect Thick Leather##4304 |n |goto Tanaris 67.22,25.77
You can find more around: |notinsticky
[67.57,28.82]
[67.85,35.25]
[68.10,39.75]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Thick Murloc Scale",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={35,60}},
items={{5785,25}},
maps={"Dustwallow Marsh"},
},[[
step
Kill Mirefin enemies around this area
collect Thick Murloc Scale##5785 |n |goto Dustwallow Marsh 58.78,9.45
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Thick Hide, Thick Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=245},levelreq={46,60}},
items={{8169,8},{4304,56}},
maps={"Un'Goro Crater"},
},[[
step
Kill enemies around this area
|tip Only beast enemies will be skinnable.
|tip Skin their corpses.
|tip You will need level 245 Skinning to collect these.
collect Thick Hide##8169 |n |goto Un'Goro Crater 67.37,72.59
|tip These have a low drop rate.
collect Thick Leather##4304 |n |goto Un'Goro Crater 67.37,72.59
You can find more around: |notinsticky
[65.75,64.16]
[70.21,55.33]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Worn Dragonscale, Thick Leather, Heavy Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=205},levelreq={40,60}},
items={{8165,8},{4304,52},{4234,44}},
maps={"Dustwallow Marsh"},
},[[
step
Kill enemies around this area
|tip Skin their corpses.
|tip You will need level 205 Skinning to collect these.
collect Worn Dragonscale##8165 |n |goto Dustwallow Marsh 44.75,66.19
|tip These have a low drop rate.
collect Thick Leather##4304 |n |goto Dustwallow Marsh 44.75,66.19
collect Heavy Leather##4234 |n |goto Dustwallow Marsh 44.75,66.19
You can find more around [44.71,74.76]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Scorpid Scale, Thick Leather, Heavy Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=215},levelreq={40,60}},
items={{8154,60},{4304,36},{4234,32}},
maps={"Tanaris"},
},[[
step
Kill Scorpid enemies around this area
|tip Skin their corpses.
|tip You will need level 215 Skinning to collect these.
collect Scorpid Scale##8154 |n |goto Tanaris 50.93,42.32
collect Thick Leather##4304 |n |goto Tanaris 50.93,42.32
collect Heavy Leather##4234 |n |goto Tanaris 50.93,42.32
You can find more around: |notinsticky
[50.33,48.18]
[44.99,44.85]
[39.08,34.58]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Devilsaur Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=270},levelreq={55,60}},
items={{15417,8}},
maps={"Un'Goro Crater"},
},[[
step
Kill Devilsaur enemies around this area
|tip Skin their corpses.
|tip These are level 54-56 Elite enemies.
|tip It is recommended you clear the area of other enemies before fighting the Devilsaur.
|tip You will need level 270 Skinning to collect these.
collect Devilsaur Leather##15417 |n |goto Un'Goro Crater 34.25,38.82
You can find more around: |notinsticky
[40.02,62.25]
[57.66,70.17]
[71.30,51.78]
[68.80,26.05]
[31.30,25.52]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Rugged Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=275},levelreq={55,60}},
items={{8170,60},{8169,12},{4304,44}},
maps={"Winterspring"},
},[[
step
Kill Ice Thistle enemies around this area
|tip You can find more inside the cave.
|tip Skin their corpses.
|tip You will need level 275 Skinning to collect these.
collect Rugged Leather##8170 |n |goto Winterspring 66.43,44.38
You can find more inside the cave at [67.67,41.72]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Warbear Leather, Rugged Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=275},levelreq={55,60}},
items={{15419,12},{8170,60}},
maps={"Western Plaguelands"},
},[[
step
kill Diseased Grizzly##1816+
|tip Skin their corpses.
|tip You will need level 275 Skinning to collect these.
collect Warbear Leather##15419 |n |goto Western Plaguelands 56.81,63.63
collect Rugged Leather##8170 |n |goto Western Plaguelands 56.81,63.63
|tip These have a low drop rate.
You can find more around: |notinsticky
[58.69,58.24]
[57.20,52.78]
[61.55,52.23]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Green Dragonscale, Thick Leather, Heavy Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=205},levelreq={40,60}},
items={{15412,8},{4304,48},{4234,36}},
maps={"Swamp of Sorrows"},
},[[
step
map Swamp of Sorrows
path follow smart; loop on; ants curved; dist 20
path	62.18,45.70	59.82,53.60	60.80,60.65	64.62,64.44	68.89,66.20
path	74.52,68.02	79.17,61.93	80.05,53.73	76.69,40.89	70.03,38.01
path	63.28,40.82
Kill Dragonkin enemies around this area as you follow the path
|tip Any Scalebane, Wyrmkin, Green or Dragonkin enemy.
|tip Skin their corpses.
|tip You will need level 205 Skinning to collect these.
collect Green Dragonscale##15412 |n
|tip These have a low drop rate.
collect Thick Leather##4304 |n
collect Heavy Leather##4234 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Blue Dragonscale, Rugged Leather, Thick Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=250},levelreq={50,60}},
items={{15415,4},{8170,40},{4304,16}},
maps={"Azshara"},
},[[
step
Kill enemies around this area
|tip Any Draconic or Blue enemy.
|tip These are level 50-54 Elite enemies.
|tip Skin their corpses.
|tip You will need level 250 Skinning to collect these.
collect Blue Dragonscale##15415 |n |goto Azshara 36.21,75.55
|tip These have a low drop rate.
collect Rugged Leather##8170 |n |goto Azshara 36.21,75.55
collect Thick Leather##4304 |n |goto Azshara 36.21,75.55
You can find more around: |notinsticky
[41.63,77.37]
[42.89,82.91]
[39.79,83.98]
[37.50,80.60]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Rugged Hide, Rugged Leather, Thick Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=275},levelreq={55,60}},
items={{8171,8},{8170,52},{4304,48}},
maps={"Winterspring"},
},[[
step
Kill Ice Thistle enemies around this area
|tip You can find more inside the cave.
|tip Skin their corpses.
|tip You will need level 275 Skinning to collect these.
collect Rugged Hide##8171 |n |goto Winterspring 66.43,44.38
|tip These have a low drop rate.
collect Rugged Leather##8170 |n |goto Winterspring 66.43,44.38
collect Thick Leather##4304 |n |goto Winterspring 66.43,44.38
You can find more inside the cave at [67.67,41.72]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Black Dragonscale, Rugged Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=260},levelreq={50,60}},
items={{15416,4},{8170,60}},
maps={"Burning Steppes"},
},[[
step
Kill enemies around this area
|tip Most of the enemies around this area are Elite.
|tip Skin their corpses.
|tip You will need level 260 Skinning to collect these.
collect Black Dragonscale##15416 |n |goto Burning Steppes 91.30,35.07
|tip These have a low drop rate.
collect Rugged Leather##8170 |n |goto Burning Steppes 91.30,35.07
You can find more around [90.73,53.59]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Heavy Scorpid Scale, Rugged Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=270},levelreq={55,60}},
items={{15408,32},{8170,40}},
maps={"Silithus"},
},[[
step
Kill Stonelash enemies around this area
|tip Skin their corpses.
|tip You will need level 270 Skinning to collect these.
collect Heavy Scorpid Scale##15408 |n |goto Silithus 31.40,38.23
collect Rugged Leather##8170 |n |goto Silithus 31.40,38.23
You can find more around: |notinsticky
[26.71,43.66]
[34.12,45.88]
[39.13,52.28]
[42.85,58.57]
[47.97,61.32]
[46.67,70.30]
[45.02,83.62]
[40.32,81.44]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Core Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=300},levelreq={60,60}},
items={{17012,4}},
},[[
step
Enter the Molten Core Raid:
Kill Ancient Core Hounds and Magmadar
|tip They are trash mobs found throughout the raid and the second raid boss.
|tip Skin their corpses.
|tip Level 61's require 305 Skinning, level 62's require 310 Skinning, and bosses require 315 Skinning.
collect Core Leather##17012 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Scale of Onyxia",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=300},levelreq={60,60}},
items={{15410,2}},
},[[
step
Enter the Onyxia's Lair Raid:
kill Onyxia##10184
|tip Skin its corpse.
|tip You will need level 315 Skinning to collect these.
collect Scale of Onyxia##15410 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Red Dragonscale, Rugged Leather",{
author="support@zygorguides.com",
meta={goldtype="route",skillreq={skinning=300},levelreq={55,60}},
items={{15414,8},{8170,60}},
maps={"Wetlands"},
},[[
step
Follow the path up |goto Wetlands 74.18,47.32 < 20 |only if walking
Kill Dragonkin enemies around this area
|tip These are level 57-62 Elite enemies.
|tip Skin their corpses.
|tip You will need level 300 Skinning to collect these.
|tip Level 61's require 305 Skinning and level 62's require 310 Skinning.
collect Red Dragonscale##15414 |n |goto 86.54,51.83
|tip These have a low drop rate.
collect Rugged Leather##8170 |n |goto 86.54,51.83
You can find more around: |notinsticky
[87.95,64.81]
[82.51,70.50]
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Primal Bat Leather",{
author="support@zygorguides.com",
},[[
step
Primal Bat Leather is currently unobtainable in Classic
It is dropped from High Priestess Jeklik in the Zul�Gurub raid
Zul�Gurub will not be added to Classic until Phase 4
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Primal Tiger Leather",{
author="support@zygorguides.com",
},[[
step
Primal Tiger Leather is currently unobtainable in Classic
It is dropped from High Priest Thekal in the Zul�Gurub raid
Zul�Gurub will not be added to Classic until Phase 4
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Dreamscale",{
author="support@zygorguides.com",
},[[
step
Dreamscale is currently unobtainable in Classic
They are dropped from the four Green Dragon world bosses
They will not be added to Classic until Phase 4
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Righteous Orb",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{12811,1}},
},[[
step
Enter the Stratholme Dungeon
|tip You will need to join and form a group for this.
Click Here Once You Have Entered the Dungeon |confirm
step
Make your way to the Crusaders' Square
|tip It will be to the left of the rat gate.
Kill Crimson enemies around this area
|tip All Crimson enemies in The Scarlet Bastion have a chance to drop the orb.
collect Righteous Orb##12811 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Demonic Rune",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{12662,4}},
maps={"Felwood"},
},[[
step
Follow the path up |goto Felwood 38.44,59.39 < 20 |only if walking
Continue following the path |goto 37.63,60.96 < 20 |only if walking
Continue following the path |goto 36.04,61.32 < 20 |only if walking
Enter the building |goto 35.39,58.61 < 20 |walk
Kill Jaedenar enemies around this area
collect Demonic Rune##12662 |n |goto 37.61,54.67
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Dark Rune",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{20520,4}},
},[[
step
Enter the Scholomance Dungeon
|tip You will need to join and form a group for this.
Click Here Once You Have Entered the Dungeon |confirm
step
Kill enemies around this area
|tip Scholomance Necromancers and Scholomance Dark Summoners are the only enemies besides bosses that will drop them.
collect Dark Rune##20520 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Sharp Claw",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={27,60}},
items={{5635,4}},
maps={"Wetlands"},
},[[
step
Follow the path up |goto Wetlands 66.98,40.59 < 20 |only if walking
Continue up the path |goto 67.64,39.88 < 20 |only if walking
Enter the cave |goto 69.33,34.86 < 20 |walk
Kill Razormaw enemies around this area
|tip Inside the cave.
collect Sharp Claw##5635 |n |goto 70.42,29.50
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Ogre Tannin",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={58,60}},
items={{18240,1}},
},[[
step
Enter the Dire Maul West Dungeon Entrance
|tip You will need to join and form a group for this.
Click Here Once You Have Entered the Dungeon |confirm
step
click Ogre Tannin Basket##179499
|tip It will be up the ramp past the broken trap.
|tip Once up the first ramp, it will be in the far northwest corner of the room.
|tip Only one person will be able to loot it.
collect Ogre Tannin##18240 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Small Venom Sac",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={25,60}},
items={{1475,8}},
maps={"Redridge Mountains"},
},[[
step
map Redridge Mountains
path follow smart; loop on; ants curved; dist 20
path	51.04,41.76	53.70,43.86	53.45,46.07	55.68,47.30	57.57,44.98
path	55.62,41.71	53.83,37.42	51.30,38.07
Kill Tarantula enemies around this area
collect Small Venom Sac##1475 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Huge Venom Sac",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={55,60}},
items={{19441,6}},
maps={"Silithus"},
},[[
step
map Silithus
path follow smart; loop on; ants curved; dist 20
path	54.03,30.39	56.79,33.30	59.06,30.91	61.29,30.65	63.54,31.68
path	66.19,30.35	65.86,26.61	64.78,22.29	63.17,18.92	61.66,15.66
path	60.22,13.51	58.24,13.36	56.02,11.72	54.46,13.22	52.99,12.72
path	51.43,13.97	49.68,16.23	51.34,19.02	51.78,22.20	52.37,25.34
path	52.30,29.17	52.30,29.17
Kill enemies around this area
collect Huge Venom Sac##19441 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Iridescent Pearl",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={23,60}},
items={{5500,1}},
maps={"Wetlands"},
},[[
step
map Wetlands
path follow smart; loop on; ants curved; dist 20
path	15.21,40.13	17.36,39.06	19.36,38.16	22.88,37.14	24.91,36.76
path	24.41,33.77	23.10,33.59	21.34,34.34	19.64,31.98	18.24,31.36
path	16.84,29.42	15.14,30.74	14.96,33.33	14.32,35.71	13.91,38.13
path	14.03,40.90
Kill Bluegill enemies around this area
collect Thick-shelled Clam##5524 |n
use the Thick-shelled Clam##5524
collect Iridescent Pearl##5500 |n
|tip These have a low drop rate.
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Black Pearl, Golden Pearl, Zesty Clam Meat",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{7971,2},{13926,2},{7974,40}},
maps={"The Hinterlands"},
},[[
step
map The Hinterlands
path follow smart; loop on; ants curved; dist 20
path	77.17,61.30	76.67,63.69	75.25,66.52	74.76,70.67	76.93,70.62
path	78.28,68.54	78.37,65.51	79.09,61.95	80.38,59.45	81.70,56.06
path	81.78,52.32	80.30,55.82	79.00,57.73
Kill Snapjaw enemies around this area
collect Big-mouth Clam##7973 |n
use the Big-mouth Clam##7973
collect Black Pearl##7971 |n
collect Golden Pearl##13926 |n
|tip These have a low drop rate.
collect Zesty Clam Meat##7974 |n
]])
ZygorGuidesViewer:RegisterGuide("GOLD\\Farming\\Giant Egg",{
author="support@zygorguides.com",
meta={goldtype="route",levelreq={50,60}},
items={{12207,12}},
maps={"Tanaris"},
},[[
step
Kill Roc enemies around this area
|tip They are found all around the zone.
collect Giant Egg##12207 |n |goto Tanaris 49.30,36.17
You can find more around: |notinsticky
[45.55,38.57]
[44.01,40.45]
[47.27,46.81]
]])
