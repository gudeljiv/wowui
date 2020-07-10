local Pins = LibStub("HereBeDragons-Pins-2.0");

-- MapID,Name,X,Y,FACTION
locations = {
	{"1453","Stormwind City","66.3","62.1","Alliance"},{"1424","Hillsbrad Footlands","49","52","Alliance"},
	{"1417","Arathi Highlands","45.8","46.2","Alliance"},{"1436","Westfall","56.6","52.6","Alliance"},
	{"1432","Loch Modan","33.8","50.8","Alliance"},{"1437","Wetlands","9.6","59.6","Alliance"},
	{"1419","Blasted Lands","65.6","24.4","Alliance"},{"1425","The Hinterlands","10","44.6","Alliance"},
	{"1433","Redridge Mountains","30.6","59.6","Alliance"},{"1431","Duskwood","77.6","44.4","Alliance"},
	{"1434","Stranglethorn Vale","27.4","77.6","Alliance"},{"1455","Ironforge","56.6","48","Alliance"},
	{"1422","Western Plaguelands","43","85.2","Alliance"},{"1428","Burning Steppes","84.4","68.2","Alliance"},
	{"1427","Searing Gorge","37.8","30.6","Alliance"},{"1423","Eastern Plaguelands","81.6","59.2","Alliance"},
	{"1413","Barrens","63","37","Alliance"},{"1446","Tanaris","51","29.2","Alliance"},
	{"1445","Dustwallow Marsh","67.4","51.2","Alliance"},{"1439","Darkshore","36.4","45.6","Alliance"},
	{"1438","Teldrassil","58.4","94","Alliance"},{"1450","Moonglade","48","67.2","Alliance"},
	{"1440","Ashenvale","34.4","48","Alliance"},{"1444","Feralas","89.4","45.8","Alliance"},
	{"1444","Feralas","30.2","43.2","Alliance"},{"1443","Desolace","64.6","10.4","Alliance"},
	{"1442","Stonetalon Mountains","36.4","7.2","Alliance"},{"1448","Felwood","62.6","24.2","Alliance"},
	{"1447","Azshara","11.8","77.6","Alliance"},{"1452","Winterspring","62.2","36.6","Alliance"},
	{"1451","Silithus","50.6","34.4","Alliance"},
	{"1450","Moonglade","32.2","66.4","Horde"},{"1412","Mulgore","47.4","58.6","Horde"},
	{"1434","Stranglethorn Vale","26.8","77.0","Horde"},{"1442","Stonetalon Mountains","45.2","59.8","Horde"},
	{"1454","Orgrimmar City","45.2","63.8","Horde"},{"1413","Northern Barrens","51.4","30.2","Horde"},
	{"1456","Thunder Bluff","46.8","50.0","Horde"},{"1443","Desolace","21.6","74.0","Horde"},
	{"1440","Ashenvale","73.2","61.6","Horde"},{"1441","Thousand Needles","45.0","49.2","Horde"},
	{"1434","Stranglethorn Vale","32.4","29.2","Horde"},{"1417","Arathi Highlands","73.0","32.6","Horde"},
	{"1448","Felwood","34.4","53.8","Horde"},{"1440","Ashenvale","12.2","33.8","Horde"},
	{"1428","Burning Steppes","65.6","24.2","Horde"},{"1447","Azshara","22.0","49.6","Horde"},
	{"1452","Winterspring","60.4","36.2","Horde"},{"1446","Tanaris","51.6","25.6","Horde"},
	{"1451","Silithus","48.8","36.6","Horde"},{"1444","Feralas","75.4","44.2","Horde"},
	{"1418","Badlands","4.0","44.8","Horde"},{"1435","Swamp of Sorrows","46.0","54.6","Horde"},
	{"1425","The Hinterlands","81.6","81.8","Horde"},{"1458","Undercity","63.6","48.6","Horde"},
	{"1421","Silverpine","45.6","42.6","Horde"},{"1424","Hillsbrad Footlands","60.2","18.6","Horde"},
	{"1423","Eastern Plaguelands","80.2","57.2","Horde"}
};

-- Players faction
local playerFaction = UnitFactionGroup("player")

function OnEnter(self,motion)
	GameTooltip:SetOwner(self,"ANCHOR_TOP");
	GameTooltip:SetText(self.tooltipText);
	GameTooltip:Show();
end

function OnLeave(self,motion)
	GameTooltip:Hide();
end

function getFrameIcon(size) 
	frame = CreateFrame("Frame", "Flight Master");
	frame:SetFrameStrata("BACKGROUND");
	frame:SetWidth(16 * size);
	frame:SetHeight(16 * size);
	frame.tooltipText = "Flight Master";
	frame.Icon = frame:CreateTexture(nil, "BACKGROUND");
	frame.Icon:SetTexture("Interface\\Addons\\Demonly-FP\\Icons\\flight.blp");
	frame.Icon:SetAllPoints(frame);
	frame.Icon.texture = frame.Icon;
	frame:SetScript("OnEnter", OnEnter);
	frame:SetScript("OnLeave", OnLeave);
	
	return frame;
end

function createMapPin(x,y,mapid)
	Pins:AddWorldMapIconMap("Demonly-FP-map",getFrameIcon(1),mapid,x/100,y/100,HBD_PINS_WORLDMAP_SHOW_WORLD);
	Pins:AddMinimapIconMap("Demonly-FP-mini",getFrameIcon(1),mapid,x/100,y/100,true,true);
end

for location = 1,#locations do
	if locations[location][5] == playerFaction
	then
		createMapPin(tonumber(locations[location][3]),tonumber(locations[location][4]),tonumber(locations[location][1]));
		--print("DEBUG: Added " .. locations[location][2]);
	end
end