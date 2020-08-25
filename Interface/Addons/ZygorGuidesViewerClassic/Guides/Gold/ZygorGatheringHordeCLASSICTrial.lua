local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("GoldGathH") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
