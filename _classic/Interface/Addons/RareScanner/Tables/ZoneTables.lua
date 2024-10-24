-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

private.CONTINENT_ZONE_IDS = {
	[1414] = { zonefilter = true, npcfilter = true, id = 1, zones = {1411,1412,1413,1438,1439,1440,1441,1442,1443,1444,1445,1446,1447,1448,1449,1450,1451,1452,1454,1456,1457} }; --Kalimdor
	[1415] = { zonefilter = true, npcfilter = true, id = 2, zones = {1416,1417,1418,1419,1420,1421,1422,1423,1424,1425,1426,1427,1428,1429,1430,1431,1432,1433,1434,1435,1436,1437,1453,1455,1458} }; --Eastern Kingdoms
	[9995] = { zonefilter = false, npcfilter = true, zones = {0} }; --Unknown
	[9997] = { zonefilter = true, npcfilter = true, zones = {100001,100002,100003,100004,100005,100006,100007,100008,100009,100010,100011,100012,100013,100014,100015,100018,100019,100020} }; --Dungeons or scenarios
}

private.SUBZONES_IDS = {

}

private.DUNGEONS_IDS = {
	[100001] = "Deadmines";
	[100002] = "Wailing Caverns";
	[100003] = "Shadowfang Keep";
	[100004] = "Razorfen Kraul";
	[100005] = "The Temple of Atal'Hakkar";
	[100006] = "Gnomeregan";
	[100007] = "Scarlet Monastery";
	[100008] = "Blackrock Depths";
	[100009] = "Blackrock Spire";
	[100010] = "Zul'Farrak";
	[100011] = "Stratholme";
	[100012] = "Upper Blackrock Spire";
	[100013] = "Dire Maul";
	[100014] = "Dire Maul (West)";
	[100015] = "Maraudon";
	[100016] = "Ragefire Chasm";
	[100017] = "Naxxramas";
	[100018] = "Zul'Gurub";
	[100019] = "Molten Core";
	[100020] = "The Stockade";
}