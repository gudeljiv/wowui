-------------------
---NovaWorldBuffs--
-------------------

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");

local naxxLoaded, azuregosLoaded, kazzakLoaded, demonfallLoaded;
function NWB:createDungeonPortalMarkers()
	NWB:createNaxxMarkers();
end

---All these marklers are changed to load on demand instead of when addon is loaded to try lessen taint issues with classic maps.

function NWB:createNaxxMarkers()
	if (naxxLoaded or NWB.expansionNum > 2) then
		return;
	end
	naxxLoaded = true;
	--This icon was part of the original art Blizzard released with the 1.11 patch.
	--This exact cut of this image was linked to me and I think is from warcraft logs.
	local iconLocation = "Interface\\AddOns\\NovaWorldBuffs\\Media\\Naxx.tga";
	--Worldmap marker.
	local obj = CreateFrame("Frame", "NWBNaxxMarker", WorldMapFrame);
	local bg = obj:CreateTexture(nil, "ARTWORK");
	bg:SetTexture(iconLocation);
	bg:SetAllPoints(obj);
	obj.texture = bg;
	obj:SetSize(15, 15);
	--World map tooltip.
	obj.tooltip = CreateFrame("Frame", "NWBNaxxMarkerTooltip", WorldMapFrame, "TooltipBorderedFrameTemplate");
	obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 22);
	obj.tooltip:SetFrameStrata("TOOLTIP");
	obj.tooltip:SetFrameLevel(9);
	obj.tooltip.fs = obj.tooltip:CreateFontString("NWBNaxxMarkerTooltipFS", "ARTWORK");
	obj.tooltip.fs:SetPoint("CENTER", 0, 0);
	obj.tooltip.fs:SetFont(NWB.regionFont, 11.5);
	obj.tooltip.fs:SetText("|CffDEDE42Naxxramas");
	obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 14);
	obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 9);
	obj:SetScript("OnEnter", function(self)
		obj.tooltip:Show();
	end)
	obj:SetScript("OnLeave", function(self)
		obj.tooltip:Hide();
	end)
	obj.tooltip:Hide();
	
	--Minimap marker.
	local obj = CreateFrame("FRAME", "NWBNaxxMarkerMini");
	local bg = obj:CreateTexture(nil, "ARTWORK");
	bg:SetTexture(iconLocation);
	bg:SetAllPoints(obj);
	obj.texture = bg;
	obj:SetSize(13, 13);
	--Minimap tooltip.
	obj.tooltip = CreateFrame("Frame", "NWBNaxxMarkerMiniTooltip", MinimMapFrame, "TooltipBorderedFrameTemplate");
	obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 12);
	obj.tooltip:SetFrameStrata("TOOLTIP");
	obj.tooltip:SetFrameLevel(9);
	obj.tooltip.fs = obj.tooltip:CreateFontString("NWBNaxxMarkerMiniTooltipFS", "ARTWORK");
	obj.tooltip.fs:SetPoint("CENTER", 0, 0.5);
	obj.tooltip.fs:SetFont(NWB.regionFont, 8);
	obj.tooltip.fs:SetText("|CffDEDE42Naxxramas");
	obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 10);
	obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 9);
	obj:SetScript("OnEnter", function(self)
		obj.tooltip:Show();
	end)
	obj:SetScript("OnLeave", function(self)
		obj.tooltip:Hide();
	end)
	obj.tooltip:Hide();
	NWB:refreshNaxxMarkers();
end

local showNaxxArrow;
function NWB:refreshNaxxMarkers()
	if (not naxxLoaded) then
		return;
	end
	NWB.dragonLibPins:RemoveWorldMapIcon("NWBNaxxMarker", _G["NWBNaxxMarker"]);
	NWB.dragonLibPins:RemoveMinimapIcon("NWBNaxxMarkerMini", _G["NWBNaxxMarkerMini"]);
	if (NWB.db.global.showNaxxWorldmapMarkers) then
		NWB.dragonLibPins:AddWorldMapIconMap("NWBNaxxMarker", _G["NWBNaxxMarker"], 1423, 0.39939300906494, 0.25840189134418);
	end
	if (NWB.db.global.showNaxxMinimapMarkers) then
		NWB.dragonLibPins:AddMinimapIconMap("NWBNaxxMarkerMini", _G["NWBNaxxMarkerMini"], 1423, 0.39939300906494, 0.25840189134418, nil, showNaxxArrow);
	end
end

local function checkMapsLoaded(usingWorldmap)
	if (usingWorldmap) then
		if (WorldMapFrame) then
			local mapID = WorldMapFrame:GetMapID();
			if (mapID == 1423) then
				NWB:createNaxxMarkers();
			elseif (mapID == 1447 and NWB.createAzuregosMarker) then
				NWB:createAzuregosMarker();
			elseif (mapID == 1419 and NWB.createKazzakMarker) then
				NWB:createKazzakMarker();
			elseif (mapID == 1440 and NWB.createDemonfallMarker) then
				NWB:createDemonfallMarker();
			elseif (mapID == 1451 and NWB.createThunderaanMarker) then
				NWB:createThunderaanMarker();
			end
		end
	else
		local _, _, zone = NWB:GetPlayerZonePosition();
		if (zone == 1423) then
			NWB:createNaxxMarkers();
		elseif (zone == 1447 and NWB.createAzuregosMarker) then
			NWB:createAzuregosMarker();
		elseif (zone == 1419 and NWB.createKazzakMarker) then
			NWB:createKazzakMarker();
		elseif (zone == 1440 and NWB.createDemonfallMarker) then
			NWB:createDemonfallMarker();
		elseif (zone == 1451 and NWB.createThunderaanMarker) then
			NWB:createThunderaanMarker();
		end
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_DEAD");
f:RegisterEvent("PLAYER_UNGHOST");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("AREA_POIS_UPDATED");
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "PLAYER_DEAD") then
		local _, _, _, _, _, _, _, instanceID = GetInstanceInfo();
		if (instanceID == 533) then
			showNaxxArrow = true;
			NWB:refreshNaxxMarkers();
		end
	elseif (event == "PLAYER_UNGHOST") then
		if (showNaxxArrow) then
			showNaxxArrow = nil;
			NWB:refreshNaxxMarkers();
		end
	elseif (event == "PLAYER_ENTERING_WORLD" or event == "AREA_POIS_UPDATED") then
		checkMapsLoaded();
	end
end)

if (WorldMapFrame) then
	hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
		checkMapsLoaded(true);
	end)
	WorldMapFrame:HookScript("OnShow", function()
		checkMapsLoaded(true);
	end)
end

local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("AREA_POIS_UPDATED");
f:SetScript("OnEvent", function(self, event, ...)
	local _, _, zone = NWB:GetPlayerZonePosition();
	if (zone == 1448) then
		NWB:createFelwoodMarkers();
	end
end)

function NWB:createExtraMarker(markers)
	for k, v in pairs(markers) do
		--Worldmap marker.
		local obj = CreateFrame("Frame", "NWBExtraDungMarker" .. v.markerName, WorldMapFrame);
		obj.texture = obj:CreateTexture(nil, "ARTWORK");
		obj.texture:SetTexture(v.icon);
		obj.texture:SetAllPoints(obj);
		obj:SetSize(15, 15);
		--World map tooltip.
		obj.tooltip = CreateFrame("Frame", "NWBExtraDungMarkerTooltip" .. v.markerName, WorldMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 22);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBExtraDungMarkerTooltipFS" .. v.markerName, "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0.5);
		obj.tooltip.fs:SetFont(NWB.regionFont, 11.5);
		obj.tooltip.fs:SetText("|CffDEDE42" .. v.tooltip);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 16);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 11);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		
		--Minimap marker.
		local obj = CreateFrame("FRAME", "NWBExtraDungMarkerMini" .. v.markerName);
		obj.texture = obj:CreateTexture(nil, "ARTWORK");
		obj.texture:SetTexture(v.icon);
		obj.texture:SetAllPoints(obj);
		obj:SetSize(13, 13);
		--Minimap tooltip.
		obj.tooltip = CreateFrame("Frame", "NWBExtraDungMarkerMiniTooltip" .. v.markerName, MinimMapFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, 12);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBExtraDungMarkerMiniTooltipFS" .. v.markerName, "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0.5);
		obj.tooltip.fs:SetFont(NWB.regionFont, 8);
		obj.tooltip.fs:SetText("|CffDEDE42" .. v.tooltip);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 10);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 9);
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		NWB.dragonLibPins:RemoveWorldMapIcon("NWBExtraDungMarker" .. v.markerName, _G["NWBExtraDungMarker" .. v.markerName]);
		NWB.dragonLibPins:RemoveMinimapIcon("NWBExtraDungMarkerMini" .. v.markerName, _G["NWBExtraDungMarkerMini" .. v.markerName]);
		if (NWB.db.global.showNaxxWorldmapMarkers) then
			NWB.dragonLibPins:AddWorldMapIconMap("NWBExtraDungMarker" .. v.markerName, _G["NWBExtraDungMarker" .. v.markerName], v.zone, v.x, v.y);
		end
		if (NWB.db.global.showNaxxMinimapMarkers) then
			NWB.dragonLibPins:AddMinimapIconMap("NWBExtraDungMarkerMini" .. v.markerName, _G["NWBExtraDungMarkerMini" .. v.markerName], v.zone, v.x, v.y);
		end
	end
end

if (not NWB.isSOD) then
	return;
end

function NWB:createAzuregosMarker()
	if (azuregosLoaded) then
		return;
	end
	local markers = {
		[1] = {
			markerName = "Azuregos",
			icon = "Interface\\Icons\\Ability_mount_drake_azure",
			tooltip = "Azuregos",
			zone = 1447,
			x = 0.43610526270177,
			y = 0.83763884877542,
		},
	};
	NWB:createExtraMarker(markers);
	azuregosLoaded = true;
end

function NWB:createKazzakMarker()
	if (kazzakLoaded) then
		return;
	end
	local markers = {
		[1] = {
			markerName = "Kazzak",
			icon = "Interface\\Icons\\Achievement_boss_kiljaedan",
			tooltip = "Lord Kazzak",
			zone = 1419,
			x = 0.47189059380033,
			y = 0.54758248379708,
		},
	};
	NWB:createExtraMarker(markers);
	kazzakLoaded = true;
end

function NWB:createDemonfallMarker()
	if (demonfallLoaded) then
		return;
	end
	local markers = {
		[1] = {
			markerName = "DFC",
			icon = "Interface\\Icons\\Achievement_boss_kelidanthebreaker",
			tooltip = "Demon Fall Canyon",
			zone = 1440,
			x = 0.84471679297417,
			y = 0.73532787093496,
		},
	};
	NWB:createExtraMarker(markers);
	demonfallLoaded = true;
end

function NWB:createThunderaanMarker()
	if (demonfallLoaded) then
		return;
	end
	local markers = {
		[1] = {
			markerName = "DFC",
			icon = "Interface\\Icons\\Achievement_boss_forgemaster",
			tooltip = "The Crystal Vale",
			zone = 1451,
			x = 0.22007650688238,
			y = 0.079368435921647,
		},
	};
	NWB:createExtraMarker(markers);
	demonfallLoaded = true;
end